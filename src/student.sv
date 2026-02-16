class Student:
    def __init__(self, student_id, name, math, physics, chemistry, biology):
        self.student_id = student_id
        self.name = name
        self.math = int(math)
        self.physics = int(physics)
        self.chemistry = int(chemistry)
        self.biology = int(biology)

    def average(self):
        return (self.math + self.physics + self.chemistry + self.biology) / 4


def generate_report():

    csv_data = [
        ["student_id", "name", "math", "physics", "chemistry", "biology"],
        ["101", "Asha", "85", "90", "78", "88"],
        ["102", "Rahul", "92", "87", "91", "84"],
        ["103", "Meena", "76", "89", "85", "90"],
        ["104", "Kiran", "95", "93", "88", "91"]
    ]

    students = []

    for row in csv_data[1:]:
        s = Student(
            row[0], row[1],
            row[2], row[3],
            row[4], row[5]
        )
        students.append(s)

    total = len(students)

    avg_math = sum(s.math for s in students) / total
    avg_phy = sum(s.physics for s in students) / total
    avg_chem = sum(s.chemistry for s in students) / total
    avg_bio = sum(s.biology for s in students) / total

    overall_avg = (avg_math + avg_phy + avg_chem + avg_bio) / 4

    top_students = sorted(students, key=lambda x: x.average(), reverse=True)[:3]

    above_90 = [
        s for s in students
        if s.math > 90 or s.physics > 90 or
           s.chemistry > 90 or s.biology > 90
    ]

    print("STUDENT REPORT")
    print("=" * 40)
    print("Total Students:", total)
    print()

    print("Class Average:")
    print("Math:", format(avg_math, ".2f"))
    print("Physics:", format(avg_phy, ".2f"))
    print("Chemistry:", format(avg_chem, ".2f"))
    print("Biology:", format(avg_bio, ".2f"))
    print()

    print("Overall Class Average:", format(overall_avg, ".2f"))
    print()

    print("Top 3 Students:")
    for s in top_students:
        print(s.name, "(", s.student_id, ")")

    print()
    print("Students scoring above 90:")
    for s in above_90:
        print(s.name, "(", s.student_id, ")")


generate_report()

      output-STUDENT REPORT
========================================
Total Students: 4

Class Average:
Math: 87.00
Physics: 89.75
Chemistry: 85.50
Biology: 88.25

Overall Class Average: 87.62

Top 3 Students:
Kiran ( 104 )
Rahul ( 102 )
Asha ( 101 )

Students scoring above 90:
Rahul ( 102 )
Kiran ( 104 )

