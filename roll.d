import std.stdio;
import std.random;
import std.array;
import std.string;
import std.conv;

void main(string[] argv) {
    if(argv.length==1) {
        help();
        return;
    }
    if(argv[1] == "-test") {
        foreach(arg; argv[2..$]) {
            test(to!int(arg));
        }
        return;
    }
    try {
        foreach(arg; argv[1..$]) {
            int val = parse(arg);
            stdout.writeln(arg, "\t => \t",val);
        }
    } 
    catch(Throwable e) {
        stdout.writeln(" (!) Error: argumentos incorrectos.");
        help();
    }
}

void help() {
    stdout.writeln(" roll: un lanzador de dados minimalista");
    stdout.writeln(" Uso: roll [<n>{a|d}<dado>[+{<n>{a|d}<dado>|modificador}]+]+");

    return;
}

int roll(int d, bool ace = false) {
    int ret = uniform(1, d+1);
    if(ace) {
        int tmp = ret;
        while(tmp == d) {
            tmp = uniform(1, d+1);
            ret += tmp;
        }
    }

    return ret;
}

int parse(string str) {
    string[] parts = split(str, "+");
    int total = 0;

    foreach(part; parts) {

        string[] subs = split(part, "-");
        total+= parsePart(subs[0]);
        subs.popFront();
        foreach(sub; subs) {
            total -= parsePart(sub);
        }
    }

    return total;
}

private int parsePart(string str) {
    int total = 0;
    auto i = indexOf(str, "d", CaseSensitive.no);
    if(i>0) { // Roll normally
        total += parseNroll(str,i,false);
    } else {
        i = indexOf(str, "a", CaseSensitive.no);
        if(i>0) { // Roll, with acing
            total += parseNroll(str,i,true);
        } else { // Is is not a roll but a modifier
            total += to!int(str);
        }
    }
    return total;
}

private int parseNroll(string str, long i, bool ace = false) {
    int total = 0;
    int nb = to!int(str[0..i]);
    int d = to!int(str[i+1..$]);
    for(int n = 0; n < nb; n++)
        total += roll(d, ace);

    return total;
 }

void test(int d, bool ace = false) {
    int[] res;
    res.length=d+1;
    int r;
    stdout.writeln("Resultados para un dado de ", d, " en porcentaje");
    for(int i = 0; i<1000000; i++) {
        r = roll(d,ace);
        res[r]++;
    }
    foreach(int die, int perc; res[1..$]) {
        stdout.writeln(die, "\t =>\t", perc/10000.0);
    }
}
