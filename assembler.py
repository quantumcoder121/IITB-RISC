# Assembler

def reg_to_bit(reg_str):
    if reg_str == 'R0':
        return '000'
    if reg_str == 'R1':
        return '001'
    if reg_str == 'R2':
        return '010'
    if reg_str == 'R3':
        return '011'
    if reg_str == 'R4':
        return '100'
    if reg_str == 'R5':
        return '101'
    if reg_str == 'R6':
        return '110'
    if reg_str == 'R7':
        return '111'

file1 = open('assembly_file.txt', 'r')
lines = file1.readlines()

machine_code_set = []

for line in lines:
    keywords = line.split()
    opcode = keywords[0]
    if opcode == 'ADD':
        RC = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        RB = reg_to_bit(keywords[3])
        machine_code = "0001" + RA + RB + RC + "000"
    if opcode == 'ADC':
        RC = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        RB = reg_to_bit(keywords[3])
        machine_code = "0001" + RA + RB + RC + "010"
    if opcode == 'ADZ':
        RC = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        RB = reg_to_bit(keywords[3])
        machine_code = "0001" + RA + RB + RC + "001"
    if opcode == 'ADL':
        RC = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        RB = reg_to_bit(keywords[3])
        machine_code = "0001" + RA + RB + RC + "011"
    if opcode == 'ADI':
        RB = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        machine_code = "0001" + RA + RB + keywords[3]
    if opcode == 'NDU':
        RC = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        RB = reg_to_bit(keywords[3])
        machine_code = "0010" + RA + RB + RC + "000"
    if opcode == 'NDC':
        RC = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        RB = reg_to_bit(keywords[3])
        machine_code = "0010" + RA + RB + RC + "010"
    if opcode == 'NDZ':
        RC = reg_to_bit(keywords[1])
        RA = reg_to_bit(keywords[2])
        RB = reg_to_bit(keywords[3])
        machine_code = "0010" + RA + RB + RC + "001"
    if opcode == 'LHI':
        RA = reg_to_bit(keywords[1])
        machine_code = "0011" + RA + keywords[2]
    if opcode == 'LW':
        RA = reg_to_bit(keywords[1])
        RB = reg_to_bit(keywords[2])
        machine_code = "0111" + RA + RB + keywords[3]
    if opcode == 'SW':
        RA = reg_to_bit(keywords[1])
        RB = reg_to_bit(keywords[2])
        machine_code = "0101" + RA + RB + keywords[3]
    if opcode == 'BEQ':
        RA = reg_to_bit(keywords[1])
        RB = reg_to_bit(keywords[2])
        machine_code = "1000" + RA + RB + keywords[3]
    if opcode == 'JAL':
        RA = reg_to_bit(keywords[1])
        machine_code = "1001" + RA + keywords[2]
    if opcode == 'JLR':
        RA = reg_to_bit(keywords[1])
        RB = reg_to_bit(keywords[2])
        machine_code = "1010" + RA + RB + keywords[3]
    if opcode == 'JRI':
        RA = reg_to_bit(keywords[1])
        machine_code = "1011" + RA + keywords[2]
    machine_code = machine_code + "\n"
    machine_code_set.append(machine_code)

file1.close()

file2 = open('machine_code_file.txt', 'w')
file2.writelines(machine_code_set)
file2.close()