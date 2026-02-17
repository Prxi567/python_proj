class Learner:
    def __init__(self, sid, fullname, m, p, c, b):
        self.sid = sid
        self.fullname = fullname
        self.marks_math = int(m)
        self.marks_phy = int(p)
        self.marks_chem = int(c)
        self.marks_bio = int(b)

    def calc_avg(self):
        total = (
            self.marks_math +
            self.marks_phy +
            self.marks_chem +
            self.marks_bio
        )
        return total / 4


def create_student_summary(src_file, result_file):
    records = []

    try:
        with open(src_file, "r") as f:
            content = f.readlines()

            for row in content[1:]:
                fields = row.strip().split(",")

                rec = Learner(
                    fields[0],
                    fields[1],
                    fields[2],
                    fields[3],
                    fields[4],
                    fields[5]
                )
                records.append(rec)

    except FileNotFoundError:
        print("Input CSV file is missing")
        return

    count = len(records)

    sum_math = sum(r.marks_math for r in records)
    sum_phy = sum(r.marks_phy for r in records)
    sum_chem = sum(r.marks_chem for r in records)
    sum_bio = sum(r.marks_bio for r in records)

    avg_math = sum_math / count
    avg_phy = sum_phy / count
    avg_chem = sum_chem / count
    avg_bio = sum_bio / count

    class_mean = (avg_math + avg_phy + avg_chem + avg_bio) / 4

    best_students = sorted(
        records,
        key=lambda x: x.calc_avg(),
        reverse=True
    )[:3]

    high_scorers = [
        r for r in records
        if r.marks_math > 90 or r.marks_phy > 90
        or r.marks_chem > 90 or r.marks_bio > 90
    ]

    output = []
    output.append("STUDENT PERFORMANCE SUMMARY")
    output.append("-" * 45)
    output.append(f"Number of students: {count}\n")

    output.append("Average marks per subject:")
    output.append(f"Maths    : {avg_math:.2f}")
    output.append(f"Physics  : {avg_phy:.2f}")
    output.append(f"Chemistry: {avg_chem:.2f}")
    output.append(f"Biology  : {avg_bio:.2f}\n")

    output.append(f"Overall class average: {class_mean:.2f}\n")

    output.append("Top performers:")
    for r in best_students:
        output.append(
            f"{r.fullname} [{r.sid}] -> Average: {r.calc_avg():.2f}"
        )

    output.append("\nStudents scoring above 90 in any subject:")
    for r in high_scorers:
        output.append(f"{r.fullname} [{r.sid}]")

    output.append("\nSubject-wise extremes:")
    output.append(
        f"Maths    - Max: {max(r.marks_math for r in records)}, "
        f"Min: {min(r.marks_math for r in records)}"
    )
    output.append(
        f"Physics  - Max: {max(r.marks_phy for r in records)}, "
        f"Min: {min(r.marks_phy for r in records)}"
    )
    output.append(
        f"Chemistry- Max: {max(r.marks_chem for r in records)}, "
        f"Min: {min(r.marks_chem for r in records)}"
    )
    output.append(
        f"Biology  - Max: {max(r.marks_bio for r in records)}, "
        f"Min: {min(r.marks_bio for r in records)}"
    )

    with open(result_file, "w") as fout:
        fout.write("\n".join(output))

    print("Student summary file created successfully")


create_student_summary("students.csv", "report.txt")

