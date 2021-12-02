horizontal_position = 0
depth = 0
aim = 0

input_file = open("input_2.txt", "r")

for line in input_file.readlines():
    command, units = line.split(" ")
    units = int(units)

    if command == "forward":
        horizontal_position += units
        depth += units * aim
    elif command == "down":
        aim += units
    else:
        aim -= units

print(horizontal_position * depth)
