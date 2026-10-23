from utils import config
from utils import diff


if __name__ == '__main__':
    conf_path = "./conf/conf.yml"
    conf = config.Config(conf_path)
    diff_test = diff.Diff(conf)
    diff_test.run_diff()

