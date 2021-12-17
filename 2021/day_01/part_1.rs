use std::fs;

// Input 1: 7
// Input 2: 1602

fn main() {
    let mut report = Vec::new();

    let contents = fs::read_to_string("input_2.txt")
        .expect("Something went wrong reading the file");

    let mut index = 0;
    let mut increased_count = 0;

    for line in contents.trim().split("\n") {
        let value: i32 = line.parse().expect("Expected a number for line");

        report.push(value);

        if index > 0 && value > report[index - 1] {
            increased_count += 1;
        }

        index += 1;
    }

    println!("Increased {} times", increased_count);
}
