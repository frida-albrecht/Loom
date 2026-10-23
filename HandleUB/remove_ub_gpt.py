import os
import openai
import requests
import re
from datetime import datetime
import json
import shutil
# import sys
# num = sys.argv[1]

# 忽略 SSL 验证（仅测试时使用）
session = requests.Session()
session.verify = False
openai.requestssession = session

# https://api.deepseek.com

#gpt-4o
#=====================Please Modify this =========================
os.environ["OPENAI_API_KEY"] = "XXXXX"
os.environ["OPENAI_BASE_URL"] = "XXXXXX"
#=================================================================

def get_gpt_response(messages, model="gpt-4o"):
    response = openai.chat.completions.create(
        model=model,
        messages=messages,
        timeout=120
    )
    return response.choices[0].message.content

def Eliminate_ub(mlir_file):
    with open(mlir_file, 'r') as file:
        tosa_mlir = file.read()

    with open("prompt.txt", 'r') as file:
        prompt0 = file.read()

    prompt = prompt0 + tosa_mlir
    messages = [{"role": "system", "content": prompt}]
    return get_gpt_response(messages)

def handle_ub(seeds,Results):
    os.makedirs(Results, exist_ok=True)
    i = 0
    time_cost = 0
    for filename in os.listdir(seeds):
        if filename.endswith(".mlir"):
            mlir_file = os.path.join(Results, filename)
            if os.path.exists(mlir_file):
                continue
            f_log = filename.replace(".mlir",".log")
            i = i + 1
            print(i)
            file_path = os.path.join(seeds, filename)

            start = datetime.now()
            message = Eliminate_ub(file_path)
            end = datetime.now()
            delta = end - start
            print(delta)
            time_cost = time_cost + delta.total_seconds()

            log_file = os.path.join(Results,filename.replace(".mlir", ".log"))
            with open(log_file, 'w') as file:
                file.write(message)

            pattern = r"```mlir\s+(.+?)```"
            matches = re.findall(pattern, message, flags=re.DOTALL)
            for j, m in enumerate(reversed(matches), 1):
                if "func.func @main()" in m:
                    with open(mlir_file, 'w') as file:
                        file.write(m.strip())
                    break
        if i == 1:
            break
    print(time_cost,i)
    print("avg time cost:", time_cost/i)

if __name__ == '__main__':
    seeds = "../Seeds/seed_raw"
    Results = "./gpt_log"
    handle_ub(seeds,Results)

