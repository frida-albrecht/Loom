import yaml
import os
import json

def load_conf(config_path):
    with open(config_path, 'r', encoding='utf-8') as f:
        return yaml.load(f, Loader=yaml.FullLoader)

class Config:
    def __init__(self, config_path):
        self.conf = load_conf(config_path)
        #common:
        common = self.conf['common']
        self.llvm_project = common['llvm_project']

        self.mlir_opt = self.llvm_project + "/build/bin/mlir-opt"
        self.mlir_runner = self.llvm_project + "/build/bin/mlir-runner"
        self.mlir_translate = self.llvm_project + "/build/bin/mlir-translate"

        self.seed_pool  = common['seed_pool']
        self.path_dir = common['path_dir']
        self.maxLowerPath = common['MAX_path']
        self.maxExtend = common['MAX_extend']
        self.test_name = common['testName']
        self.test_mode = common['mode']


        # diff
        diff = self.conf['diff']
        self.temp_ir_path = diff['temp_ir_path']
        os.makedirs(self.temp_ir_path, exist_ok=True)
        self.run_time = diff['run_time']

        #report
        report = self.conf['report']
        self.bug_path = report['savepath']

        # # opt
        opt = self.conf['opt']
        self.opts_by_dialect = opt['opts_by_dialect']
        self.all_opts = opt['opts']
        self.random_rate = opt['random_rate']
        self.pass_num = opt['opt_num']



        with open(self.opts_by_dialect, 'r', encoding='utf-8') as f:
            self.opt_pass_by_dialect = json.load(f)
        with open(self.all_opts, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        self.all_pass_list = [line.rstrip('\r\n').lstrip("-") for line in lines]


    def get(self, key, default=None):
        keys = key.split('.')
        conf_section = self.conf
        for k in keys:
            if isinstance(conf_section, dict) and k in conf_section:
                conf_section = conf_section[k]
            else:
                return default
        return conf_section

    def _add_args_to_conf(self, args):
        for key, value in vars(args).items():
            if value is not None:
                self.conf[key] = value


    def __getitem__(self, key):
        return self.get(key)

    def __repr__(self):
        return f"Config({self.conf})"


def extract_values(data):
    values = []
    if isinstance(data, dict):
        for v in data.values():
            values.extend(extract_values(v))
    elif isinstance(data, list):
        for item in data:
            values.extend(extract_values(item))
    else:
        values.append(data)

    return values

