try:
    while(True):
        f = open("output.txt", "a")
        x = input()
        print("-> {}".format(x))
        f.write(x.lstrip().rstrip() + "\n")
        f.close()
except KeyboardInterrupt:
    exit()