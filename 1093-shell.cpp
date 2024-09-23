#include <bits/stdc++.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <dirent.h>
using namespace std;

vector<string> parse(string& input) {
    vector<string> tokens;
    string token;
    for (int i = 0; i < input.size(); ++i) {
        if (input[i] == ' ') {
            if (token.size())
                tokens.push_back(token);
            token.clear();
        } else {
            token.push_back(input[i]);
        }
    }
    if (token.size())
        tokens.push_back(token);
    return tokens;
}

void cd(const vector<string>& arguments) {
    if (arguments.size() > 1) {
        if (chdir(arguments[1].c_str()) != 0)
            perror("chdir failed");
    } else {
        cerr << "missing operand\n";
    }
}

void pwd() {
    char current_dir[1024];
    if (getcwd(current_dir, sizeof(current_dir)) != NULL)
        cout << current_dir << endl;
    else
        perror("getcwd failed");
}

void echo(const vector<string>& arguments) {
    for (int i = 1; i < arguments.size(); i++) {
        cout << arguments[i] << " ";
    }
    cout << endl;
}

void ls() {
    DIR* directory;
    struct dirent* entry;
    directory = opendir(".");
    if (directory == NULL) {
        perror("opendir failed");
        return;
    }
    while ((entry = readdir(directory)) != NULL)
        cout << entry->d_name << " ";
    cout << endl;
    closedir(directory);
}

void execute(string& input) {
    vector<string> arguments = parse(input);
    if (arguments.empty())
        return;

    switch (arguments[0][1]) {
        case 'd':
            if (arguments[0] == "cd") cd(arguments);
            break;
        case 'w':
            if (arguments[0] == "pwd") pwd();
            break;
        case 'c':
            if (arguments[0] == "echo") echo(arguments);
            break;
        case 's':
            if (arguments[0] == "ls") ls();
            break;
        case 'x':
            if (arguments[0] == "exit") exit(0);
            break;
        default:
            cerr << arguments[0] << ": command not found" << endl;
    }
}

int main() {
    string input_line;
    while (true) {
        cout << "> ";
        getline(cin, input_line);
        execute(input_line);
    }
}