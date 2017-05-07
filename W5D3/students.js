function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function () {
  return `${this.firstName} ${this.lastName}`;
};

Student.prototype.enroll = function(course) {
  if (!this.courses.includes(course)){
    this.courses.push(course);
    //TODO update list of enrolled students in course
    course.addStudent(this);
  }
  return this.courses;
};

Student.prototype.courseLoad = function() {
  let courseInfo = {};
  for (let i = 0; i < this.courses.length; i++) {
    let dept = this.courses[i].dept;
    if (courseInfo[dept]) {
      courseInfo[dept] += this.courses[i].numCredits;
    } else {
      courseInfo[dept] = this.courses[i].numCredits;
    }
  }
  return courseInfo;
};

function Course(courseName, dept, numCredits, days, timeBlock){
  this.courseName = courseName;
  this.dept = dept;
  this.numCredits = numCredits;
  this.students = [];
  this.days = days;
  this.timeBlock = timeBlock;
}

Course.prototype.addStudent = function(student){
  this.students.push(student);
};

const Jane = new Student("Jane", "Doe");
const Isaiah = new Student("Isaiah", "Thomas");

const Literature = new Course("Literature", "Social Studies", 4, ["tue", "mon", "fri"], 1);
const Art = new Course("Art", "Creative", 3, ["tue", "sun", "thu"], 3);
const Basketball = new Course("Bball", "Creative", 10, ["tue", "sun", "thu"], 1);

Isaiah.enroll(Art);
Isaiah.enroll(Literature);
Isaiah.enroll(Basketball);

console.log(Isaiah.courseLoad());
// console.log(Isaiah.courses);

Course.prototype.conflictsWith = function(otherCourse) {
  if (otherCourse.timeBlock !== this.timeBlock) {
    return false;
  }
  for (let i=0;i<this.days.length;i++){
    if (otherCourse.days.includes(this.days[i])) {
      console.log("I'm stuck!");
      return true;
    }
  }
  return false;
};

console.log(Literature.conflictsWith(Basketball));
