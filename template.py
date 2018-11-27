from sys import stdin
from logging import getLogger, StreamHandler, DEBUG

is_read_from_file = True
is_debug_enabled = True
data_file = "template.txt"

log = getLogger(__name__)
handler = StreamHandler()
handler.setLevel(DEBUG)
log.setLevel(DEBUG)
log.addHandler(handler)
log.propagate = False
log.disabled = (not is_debug_enabled)


def read_input_from_stdin():
    input_lines = filter(lambda l: len(l), map(lambda l2: l2.strip(), stdin.readlines()))

    return input_lines


def read_input_from_file():
    with open(data_file, mode='r') as f:
        input_lines = list(filter(lambda row: row, f.read().split('\n')))
    return input_lines


def str_list_to_int_list(a):
    return list(map(lambda x: list(map(int, x.split(' '))), a))


def str_list_to_list_of_str_list(a):
    return list(map(lambda x: x.split(' '), a))


def main():
    if is_read_from_file:
        input_lines = read_input_from_file()
    else:
        input_lines = read_input_from_stdin()

    log.debug('input_lines: %s', input_lines)

    input_values = str_list_to_int_list(input_lines)

    log.debug('input_values: %s', input_values)


if __name__ == '__main__':
    main()
