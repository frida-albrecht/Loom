import json
import logging
import os
import re
import json
import signal
import filecmp
import shutil
from datetime import datetime, timedelta
import subprocess

from utils.config import Config
from datetime import datetime
import time
import random
from collections import Counter
from itertools import islice

import numpy as np

def split_list_randomly(lst, max_extend):
    """
    Divide into n lowering stages
    """
    n = max_extend + 1
    n = min(n, len(lst)-2)

    cut_points = sorted(random.sample(range(1, len(lst)), n - 1))
    result = []
    prev_index = 0
    for cut in cut_points:
        result.append(lst[prev_index:cut])
        prev_index = cut
    result.append(lst[prev_index:])
    return result

def is_inconsistency(records):
    first_elements = [t[0] for t in records]
    if len(list(set(first_elements))) <= 1:
        return False
    else:
        return True

def random_sample(my_list,num):
    # Randomly sample elements from the list, ensuring the sample size
    # does not exceed the length of the list
    return random.sample(my_list, min(num,len(my_list)))

def find_mlir_files(directory):
    # Recursively find all .mlir and .npy files in the directory,
    # excluding files with the .llvm.mlir suffix
    mlir_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.mlir') or file.endswith('.npy'):
                if not file.endswith('.llvm.mlir'):
                    mlir_files.append(os.path.join(root, file))
    return mlir_files

def check_ir_change(before_file_path: str, after_file_path: str) -> bool:
    # Check whether the IR file has changed
    if not os.path.exists(after_file_path):
        return False
    return not filecmp.cmp(before_file_path, after_file_path, shallow=False)


def get_data(stdout):
    return stdout.split("\n")[-2]


def grouping(my_list):
    # Group list elements by value and record their indices
    # Example: ['a','b','a','c','d','c'] -> {'b':[1], 'd':[4], 'a':[0,2], 'c':[3,5]}
    from collections import defaultdict
    index_dict = defaultdict(list)
    for idx, value in enumerate(my_list):
        index_dict[value].append(idx)
    sorted_dict = dict(sorted(index_dict.items(), key=lambda item: len(item[1])))
    return sorted_dict

def exec_cmd(cmd):
    # Execute a shell command with a timeout and capture stdout/stderr
    stderr = ""
    stdout = ""
    pro = subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE, universal_newlines=True, encoding="utf-8",
                           preexec_fn=os.setsid,errors='replace')
    try:
        stdout, stderr = pro.communicate(timeout=10)
        return_code = pro.returncode
    except subprocess.TimeoutExpired:
        os.killpg(pro.pid, signal.SIGTERM)
        return_code = 999
    res = ExecResult(cmd, return_code, stderr, stdout)
    return res

class MLIRSeed:
    """
    Naming of related intermediate files
    """
    def __init__(self, seed_dir: str):
        prefix = seed_dir.split(".mlir")[0]
        self.sid = seed_dir.split("/")[-1].split(".mlir")[0]
        self.mlir_name = f"{self.sid}.mlir"
        self.mlir_path = seed_dir
        self.lowering_ir = prefix + ".llvm.mlir"
        self.llvm_ir = prefix + ".ll"
        self.executable =  prefix + ".out"

class ExecResult:
    """
    Save the execution result.
    """
    def __init__(self, cmd : str, return_code: str,stderr: str,stdout: str):
        self.cmd = cmd
        self.return_code = return_code
        self.stderr = stderr
        self.stdout = stdout


class Diff:
    def __init__(self, config: Config):
        self.config = config
        self.clang = self.config.llvm_project + "/clang-build/bin/clang"
        self.lib_path = self.config.llvm_project + "/build/lib"
        os.environ['LD_LIBRARY_PATH'] = f'{self.lib_path}:' + os.environ.get('LD_LIBRARY_PATH', '')
        self.shared_libs = f"{self.lib_path}/libmlir_runner_utils.so,{self.lib_path}/libmlir_c_runner_utils.so,{self.lib_path}/libmlir_async_runtime.so"

        self.temp_ir_path = self.config.temp_ir_path + self.config.test_name
        if os.path.exists(self.temp_ir_path):
            os.system(f"rm -rf {self.temp_ir_path}/*")

        self.cur_lowering_path = None
        self.cur_tosa_seed = None

        self.opt_pass_by_dialect = self.config.opt_pass_by_dialect
        self.opt_pass = self.config.all_pass_list


        # define some status
        self.lowering_success = "lowering_success"
        self.lowering_timeout = "lowering_timeout"
        self.lowering_crash = "lowering_crash"
        self.lowering_failed = "lowering_failed"
        self.opt_success = "opt_success"
        self.opt_timeout = "opt_timeout"
        self.opt_crash = "opt_crash"
        self.opt_failed = "opt_failed"
        self.translate_timeout = "translate_timeout"
        self.translate_crash = "translate_crash"
        self.translate_success = "translate_success"
        self.translate_failed = "translate_failed"
        self.clang_timeout = "clang_timeout"
        self.clang_crash = "clang_crash"
        self.clang_success = "clang_success"
        self.clang_failed = "clang_failed"
        self.execute_timeout = "execute_timeout"
        self.execute_crash = "execute_crash"
        self.execute_success = "execute_success"
        self.execute_failed = "execute_failed"

        self.lowering_flag = "lower"
        self.opt_flag = "opt"
        self.translate_flag = "translate"
        self.clang_flag = "clang"
        self.execute_flag = "execute"

        self.report_dir = os.path.join(self.config.bug_path,self.config.test_name)
        os.makedirs(self.report_dir, exist_ok=True)

        self.seed_num = 0


        self.maxLowerPath = self.config.maxLowerPath
        self.maxExtend = self.config.maxExtend
        self.opt_test_num = 5


        print("Start Fuzzing!")
        print("maxpath", self.maxLowerPath)
        print("maxextend", self.maxExtend)

        self.temp_process_path = ""


    def lowering(self, cmd, seed):
        """
        Lowering
        """
        cmd = cmd + f" -o {seed.lowering_ir}"
        res  = exec_cmd(cmd)

        if res.return_code == 0 and os.path.exists(seed.lowering_ir) and self.only_llvm(seed.lowering_ir):
            return self.lowering_success
        else:
            self.handle_exception(self.lowering_flag,seed.mlir_path,res)
            return self.lowering_failed

    def translate_to_llvm(self, seed):
        """
        Compile the given llvm ir to executable.
        """
        if seed.sid not in seed.lowering_ir:
            return self.translate_failed

        cmd = " ".join([self.config.mlir_translate, seed.lowering_ir,"--mlir-to-llvmir",
                                 "-o", seed.llvm_ir])
        res = exec_cmd(cmd)

        logging.info(f"[Diff_TEST] translate --> rcode: [{res.return_code}]")
        if res.return_code == 0 and os.path.exists(seed.llvm_ir):
            return self.translate_success
        else:
            self.handle_exception(self.translate_flag,seed.lowering_ir,res)
            return self.translate_failed


    def execute_one(self,pass_seq,input_mlir,output_mlir):
        cmd = self.build_lowering_cmd(pass_seq,input_mlir)
        cmd = cmd + f" -o {output_mlir}"
        res = exec_cmd(cmd)
        return res


    def fix_llvm_ir(self,llvm_ir):
        with open(llvm_ir, "r") as f:
            content = f.read()
        if " nuw " in content:
            new_content = content.replace(" nuw "," ")
            with open(llvm_ir, "w") as f:
                f.write(new_content)

    def compile_to_executable(self, seed):
        """
        Compile the given llvm ir to executable.
        """
        if seed.sid not in seed.llvm_ir:
            return self.clang_failed
        c_runner_utils_lib = f"{self.lib_path}/libmlir_c_runner_utils.so"
        float16_utils_lib = f"{self.lib_path}/libmlir_float16_utils.so"
        runner_utils_lib = f"{self.lib_path}/libmlir_runner_utils.so"
        cpp_std_lib = f"/usr/lib/gcc/x86_64-linux-gnu/11/libstdc++.so"

        self.fix_llvm_ir(seed.llvm_ir)
        cmd = " ".join([self.clang, "-lm", seed.llvm_ir,
                        c_runner_utils_lib, float16_utils_lib, runner_utils_lib, cpp_std_lib,
                        "-o", seed.executable])

        res = exec_cmd(cmd)

        logging.info(f"[Diff_TEST] compile --> rcode: [{res.return_code}]")
        if res.return_code == 0 and os.path.exists(seed.executable):
            return self.clang_success
        else:
            self.handle_exception(self.clang_flag,seed.llvm_ir,res)
            return self.clang_failed



    def run_executable(self, executable):
        """
        Compile the given llvm ir to executable.
        """
        if not os.path.exists(executable):
            return self.execute_failed,None

        res = exec_cmd(executable)
        logging.info(f"[Diff_TEST] execute --> rcode: [{res.return_code}]")
        if res.return_code == 64 or res.return_code == 0:
            return self.execute_success,res.stdout
        else:
            self.handle_exception(self.execute_flag,executable,res)
            return self.execute_failed,None

    def build_lowering_cmd(self,pass_seq,mlir_path):
        pass_seq = [s if s.startswith('-') else '-' + s for s in pass_seq]
        cmd = f"{self.config.mlir_opt} {mlir_path}  {pass_seq[0]}"
        for pass_ in pass_seq[1:]:
            cmd = cmd + f" | {self.config.mlir_opt} {pass_} "
        return cmd



    def get_pass_by_dialect(self,intput_ir):
        passes = []
        pass_dict= self.opt_pass_by_dialect
        ops_list = self.get_op(intput_ir)
        dialect = {op.split(".")[0] for op in ops_list}
        if dialect:
            passes = [v for k in dialect if k in pass_dict for v in pass_dict[k]]
        return passes


    def extend_by_random(self,seed,path):
        cur_ir = seed.mlir_path
        results = []

        split_path = split_list_randomly(path,self.maxExtend)
        final_path = []

        for i, lpass in enumerate(split_path):
            # opt
            vaild_record = []
            if not os.path.exists(cur_ir):
                print("cur_ir does not exist")
                break
            optional_pass = self.opt_pass
            for t in range(self.opt_test_num):
                pass_seq = random_sample(optional_pass, self.config.pass_num)
                cmd = self.build_lowering_cmd(pass_seq,cur_ir)
                opt_mlir = cur_ir.replace(".mlir",f"-opt{t}.mlir")
                cmd = cmd + f" -o {opt_mlir}"
                res = exec_cmd(cmd)
                logging.info(f"[Diff_TEST] trying opt--> rcode: [{res.return_code}]")
                if res.return_code != 0:
                    self.handle_exception(self.opt_flag,cur_ir,res)
                else:
                    ischange = check_ir_change(cur_ir,opt_mlir)
                    logging.info(f"[Diff_TEST] check_ir_change: [{ischange}]")
                    if ischange:
                        vaild_record.append((opt_mlir,"opt",pass_seq))
                        print(f"✅ opt success.")

            # lower
            vaild_record.append((cur_ir,"low",lpass))
            low_mlir = os.path.join(self.temp_process_path, str(i) + ".mlir")
            if vaild_record:
                for opt_ir,str_,lst in vaild_record:
                    res = self.execute_one(lpass,opt_ir,low_mlir)
                    logging.info(f"[Diff_TEST] trying lower--> rcode: [{res.return_code}]")
                    if res.return_code == 0:
                        cur_ir = low_mlir
                        final_path.append((str_,lst))
                        if str_ == "opt":
                            final_path.append(("low",lpass))
                        break
                    else:
                        self.handle_exception(self.opt_flag,cur_ir,res)

            if os.path.exists(low_mlir) and self.only_llvm(low_mlir):
                print(f"✅ lowering success.")
                new_seed = MLIRSeed(low_mlir)
                new_seed.lowering_ir = low_mlir
                print(low_mlir)
                if self.translate_success  == self.translate_to_llvm(new_seed) and \
                        self.clang_success == self.compile_to_executable(new_seed):
                    state, stdout = self.run_executable(new_seed.executable)
                    if self.execute_success == state:
                        results.append((get_data(stdout),new_seed.mlir_path,final_path))
            else:
                print(f"❌  Failed to low_mlir.")
        return results



    def extend_by_dialect_with_random(self,seed,path):
        cur_ir = seed.mlir_path
        results = []
        split_path = split_list_randomly(path,self.maxExtend)
        final_path = []

        for i, lpass in enumerate(split_path):
            # opt
            vaild_record = []
            if not os.path.exists(cur_ir):
                print("cur_ir does not exist")
                break
            optional_pass = self.get_pass_by_dialect(cur_ir)
            if not optional_pass:
                optional_pass = self.opt_pass
            for t in range(self.opt_test_num):
                p = random.random()
                if p > self.config.random_rate:
                    pass_seq = random_sample(optional_pass, self.config.pass_num)
                else:
                    pass_seq = random_sample(self.opt_pass, self.config.pass_num)

                cmd = self.build_lowering_cmd(pass_seq,cur_ir)
                opt_mlir = cur_ir.replace(".mlir",f"-opt{t}.mlir")
                cmd = cmd + f" -o {opt_mlir}"
                res = exec_cmd(cmd)
                logging.info(f"[Diff_TEST] trying opt--> rcode: [{res.return_code}]")
                if res.return_code != 0:
                    self.handle_exception(self.opt_flag,cur_ir,res)
                else:
                    ischange = check_ir_change(cur_ir,opt_mlir)
                    logging.info(f"[Diff_TEST] check_ir_change: [{ischange}]")
                    if ischange:
                        vaild_record.append((opt_mlir,"opt",pass_seq))
                        print(f"✅ opt success.")

            # lower
            vaild_record.append((cur_ir,"low",lpass))
            low_mlir = os.path.join(self.temp_process_path, str(i+1) + ".mlir")
            if vaild_record:
                for opt_ir,str_,lst in vaild_record:
                    res = self.execute_one(lpass,opt_ir,low_mlir)
                    logging.info(f"[Diff_TEST] trying lower--> rcode: [{res.return_code}]")
                    if res.return_code == 0:
                        cur_ir = low_mlir
                        final_path.append((str_,lst))
                        if str_ == "opt":
                            final_path.append(("low",lpass))
                        break
                    else:
                        self.handle_exception(self.opt_flag,cur_ir,res)

            if os.path.exists(low_mlir) and self.only_llvm(low_mlir):
                print(f"✅ lowering success.")
                new_seed = MLIRSeed(low_mlir)
                new_seed.lowering_ir = low_mlir
                if self.translate_success  == self.translate_to_llvm(new_seed) and \
                        self.clang_success == self.compile_to_executable(new_seed):
                    state, stdout = self.run_executable(new_seed.executable)
                    if self.execute_success == state:
                        results.append((get_data(stdout),new_seed.mlir_path,final_path))

        return results


    def save_results(self,output_file,line,tosasid,return_code,stderr,stdout):
        content = " "
        res_content = {
            "path":line,
            "LLVM_IR":content,
            "tosasid":int(tosasid),
            "return_code": return_code,
            "stderr": stderr,
            "stdout": stdout,
        }

        self.db_manager.save_runner_result(res_content)

    def report_inconsistency(self, records, flag):
        sid = self.cur_tosa_seed.split("/")[-1].split(".mlir")[0]
        data = [t[0] for t in records]
        group_output = grouping(data)

        bug_dir = os.path.join(self.report_dir,"inconsistency",sid)
        os.makedirs(bug_dir, exist_ok=True)

        bug_file = shutil.copy(self.cur_tosa_seed, bug_dir)
        timestamp = datetime.now().strftime('%H%M%S')
        bug_json = bug_file.replace(".mlir",f"_{timestamp}_{flag}.json")

        logging.info(f"[report_inconsistency] {bug_json}")

        bug_dict = {}

        bug_dict["mlir"] = self.cur_tosa_seed
        bug_dict["results"] = group_output
        pass_list = [res[2] for res in records]
        bug_dict["path"]= pass_list

        with open(bug_json, "w", encoding="utf-8") as f:
            json.dump(bug_dict, f, ensure_ascii=False, indent=4)


    def handle_crash(self,flag, bug_file,result):
        print("crash")
        bug_log = bug_file.replace(".mlir",f".{flag}.crash.log")
        if os.path.exists(bug_log):
            bug_log = bug_file.replace(".mlir",f".{hash(datetime.now)}.{flag}.crash.log")

        logging.info(f"[handle_exception] {bug_log}")

        with open(bug_log, 'w', encoding='utf-8') as f:
            f.write(f"e2e lowering cmd:\n{self.cur_lowering_path}")
            f.write(f"\nbug-triggering cmd:\n{result.cmd}")
            f.write(f"\n//{result.stderr}")

    def handle_timeout(self,flag, bug_file,result):
        print("timeout")
        bug_log = bug_file.replace(".mlir",f".{flag}.timeout.log")
        if os.path.exists(bug_log):
            bug_log = bug_file.replace(".mlir",f".{hash(datetime.now)}.{flag}.timeout.log")

        logging.info(f"[handle_exception] {bug_log}")

        with open(bug_log, 'w', encoding='utf-8') as f:
            f.write(f"e2e lowering cmd:\n{self.cur_lowering_path}")
            f.write(f"\nbug-triggering cmd:\n{result.cmd}")

    def handle_exception(self,flag,cur_ir_file, res):
        if res.return_code > 130:
            print(flag,"❌ handle_exception")
            sid = self.cur_tosa_seed.split("/")[-1].split(".mlir")[0]
            bug_dir = os.path.join(self.report_dir,"crash",sid)
            os.makedirs(bug_dir, exist_ok=True)
            shutil.copy(self.cur_tosa_seed, bug_dir)
            bug_file = shutil.copy(cur_ir_file, bug_dir)

            if res.return_code > 130:
                self.handle_crash(flag,bug_file,res)
            elif res.return_code == 999:
                self.handle_timeout(flag,bug_file,res)


    def only_llvm(self, file):
        # Check if it has been completely lowered to LLVM dialect
        ops_list = self.get_op(file)
        if not ops_list or ['builtin.module']==ops_list:
            return False
        for op in ops_list:
            if not op.startswith("llvm.") and op not in {"builtin.module"}:
                return False
        return True

    def run_e2e(self,lower_path,seed):
        """
        Run End-to-end compilation
        """
        cmd = self.build_lowering_cmd(lower_path,seed.mlir_path)
        if self.lowering_success == self.lowering(cmd, seed) and  \
                self.translate_success  == self.translate_to_llvm(seed) and \
                self.clang_success == self.compile_to_executable(seed):
            return True
        else:
            return False

    def get_op(self, file):
        """
        Get operations from IR
        """
        pattern = r'\b[A-Za-z_][A-Za-z0-9_]*\.[A-Za-z_][A-Za-z0-9_]*\b'
        with open(file, "r") as f:
            mlir_text = f.read()
        matches = re.findall(pattern, mlir_text)
        ops_list = sorted(set(matches))
        return ops_list


    def run_diff(self):
        """
        Main fuzzing process.
        """
        start = datetime.now()
        end = start + timedelta(seconds=self.config.run_time*3600)

        # log record
        log_dir = "./log"
        os.makedirs(log_dir, exist_ok=True)
        for handler in logging.root.handlers[:]:
            logging.root.removeHandler(handler)
        log_filename = os.path.join(log_dir,f"{self.config.test_name}_diff.log")
        logging.basicConfig(
            filename=log_filename,
            filemode="a",
            level=logging.INFO,
            format='%(asctime)s - %(message)s',
            datefmt='%m%d_%H:%M:%S'
        )

        #  load seeds
        seeds = find_mlir_files(self.config.seed_pool)
        random.shuffle(seeds)
        for seed_file in seeds:
            dmaxExtendame, file_name = os.path.split(seed_file)
            # load pure_lowering_path
            if "FE" in self.config.test_mode:
                path_npy = "./conf/paths/fixed5path.npy"
            else:
                path_npy = os.path.join(self.config.path_dir,file_name.replace(".mlir",".npy"))
            if not os.path.exists(path_npy):
                print(path_npy," not exist")
                continue
            path_list = np.load(path_npy,allow_pickle=True).tolist()
            if len(path_list) == 0:
                print("The lowering path is empty, skip cur seed")
                continue

            lowering_paths = random_sample(path_list,self.maxLowerPath)
            self.seed_num = self.seed_num + 1
            self.cur_tosa_seed = seed_file
            sid = file_name.split(".")[0]

            logging.info(f"[Diff_TEST] seed{self.seed_num}: [{sid}]")
            print(f"#Testing {self.seed_num}/{len(seeds)} {file_name}")

            extend_record = []
            counter = 0

            records = []

            #Iterate through each pure_lowering_path
            for idx, path in enumerate(lowering_paths):
                self.temp_process_path = os.path.join(self.temp_ir_path, str(sid), str(counter))
                if os.path.exists(self.temp_process_path):
                    shutil.rmtree(self.temp_process_path)
                os.makedirs(self.temp_process_path, exist_ok=True)
                cur_seed_file = os.path.join(self.temp_process_path,"0.mlir")
                os.system(f"cp -r {seed_file} {cur_seed_file}")

                if isinstance(path, str):
                    path = path.split("\n")
                seed = MLIRSeed(cur_seed_file)
                all_record = []

                # If the lowering is successful
                if self.run_e2e(path, seed):
                    state, stdout = self.run_executable(seed.executable)
                    if self.execute_success == state:
                        record1 = (get_data(stdout),seed.mlir_path,path)
                        extend_record = []
                        if "OL" in self.config.test_mode: # Disable extension
                            extend_record = []
                        elif "SE" in self.config.test_mode: # only expand once
                            self.maxExtend = 1
                            extend_record = self.extend_by_dialect_with_random(seed,path)
                        elif "RE" in self.config.test_mode: # extend with random transformations
                            extend_record = self.extend_by_random(seed,path)
                        else: #ALL:  complete implementation
                            extend_record = self.extend_by_dialect_with_random(seed,path)
                    if extend_record:
                        all_record.append(record1)
                        all_record.extend(extend_record)

                        if len(all_record)>1:
                            # Oracle_Diff
                            if is_inconsistency(all_record):
                                self.report_inconsistency(all_record,"opt")

                    records.append(record1)
                else:
                    print("Failed to lower")
                counter = counter + 1

            if len(records)>1:
                # Oracle_PLP
                if is_inconsistency(records):
                    self.report_inconsistency(records,"low")

            if datetime.now() >= end:
                print("overrrrrrrrrrr")
                print(f"test time：{(datetime.now() - start).total_seconds()} 秒")
                break





