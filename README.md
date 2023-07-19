# Test LMS System

Test LMS System is used by schools to manage courses, enrollments, students, and exam evaluations. It is available through web based portal and json API. 

There are 3 types of users in system:
1. Super admin
2. School admin
3. Student

## Super Admin
Super admin can manage schools. Admin can perform create, update, and delete operations on school.

## School Admin
School admin can manage courses, batches, and students. Courses have to be assigned to batches. Once a batch is created admin can mark it as enrollment_open status so student can enroll.

## Student

Students are able to make a request to enroll in a batch. Students can also see their classmates and see the progress cards as well.


## Installation

git clone the repository

```bash
bundle install
rails db:seed
```

This creates 2 default users in system.
1. Super admin: (email: super_admin@testlms.com, password: test123)
2. School admin: (email: school_admin@testlms.com, password: test123)

##API Postman Collection:


## Screenshots

## Login Screen
![alt text](https://github.com/pratikganvir/learning_management_system/blob/main/Screenshots/login_page.png)

## Admin Dashboard
![alt text](https://github.com/pratikganvir/learning_management_system/blob/main/Screenshots/admin_dashboard.png)

## School List
![alt text](https://github.com/pratikganvir/learning_management_system/blob/main/Screenshots/schools_list.png)

## School Admin Dashboard
![alt text](https://github.com/pratikganvir/learning_management_system/blob/main/Screenshots/school_admin_dashboard.png)

## Student Dashboard
![alt text](https://github.com/pratikganvir/learning_management_system/blob/main/Screenshots/student_dashboard.png)

## Request Enrollment Page
![alt text](https://github.com/pratikganvir/learning_management_system/blob/main/Screenshots/batches_available.png)

## Classmate Progress Card Page
![alt text](https://github.com/pratikganvir/learning_management_system/blob/main/Screenshots/progress_card.png)

