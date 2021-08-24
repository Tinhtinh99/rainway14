import java.util.Scanner;

public class Program {
	public static void main(String[] args) {

		// ADD OBJECT TO DEPARTMENT
		Department phongGiamDoc = new Department(1, "PhongGiamDoc");
		Department phongHoc = new Department(2, "QuanLyTrungTam");
		Department phongBoMon = new Department(3, "PhongMentor");
		Department phongCSKH = new Department(3, "CSKH");
		// ADD OBJECT TO POSITION
		Position giamDoc = new Position(1, "TongGiamDoc");
		Position quanLy = new Position(2, "TruongQuanLy");
		Position mentor = new Position(3, "ThayCo");
		Position NvCSKH = new Position(4, "NhanVienCSKH");
		// ADD OBJECT TO ACCOUNT
		Account account1 = new Account(1, "acc1@gmail.com", "acc1", "Nguyễn acc 1", phongGiamDoc, giamDoc,"22/08/2021");
		Account account2 = new Account(2, "acc2@gmail.com", "acc2", "Nguyễn acc 2", null , null , "22/08/2021");
		Account account3 = new Account(3, "acc3@gmail.com", "acc3", "Nguyễn acc 3", phongHoc, quanLy, "22/08/2021");
		Account account4 = new Account(4, "acc4@gmail.com", "acc4", "Nguyễn acc 4", null , mentor, "22/08/2021");
		Account account5 = new Account(5, "acc5@gmail.com", "acc5", "Nguyễn acc 5", phongBoMon, mentor, "22/08/2021");
		Account account6 = new Account(6, "acc6@gmail.com", "acc6", "Nguyễn acc 6", phongCSKH, NvCSKH, "22/08/2021");
		Account account7 = new Account(7, "acc7@gmail.com", "acc7", "Nguyễn acc 7", phongCSKH, NvCSKH, "22/08/2021");
		// ARRAY ACCOUNT OF GROUP
		Account[] accountHoiDong = new Account[3];
		accountHoiDong[0] = account1;
		Account[] accountQuanLy = new Account[5];
		accountQuanLy[0] = account2;
		accountQuanLy[1] = account3;
		Account[] accountGiaoDuc = new Account[10];
		accountGiaoDuc[0] = account4;
		accountGiaoDuc[1] = account5;
		Account[] accountCSKH = new Account[5];
		accountCSKH[0] = account6;
		accountCSKH[1] = account7;
		// ADD OBJECT TO GROUP
		Group groupHoiDong = new Group(1, "Nhóm Hội Đồng", account1, "23/08/2021", accountHoiDong, "24/08/2021");
		Group groupQuanLy = new Group(2, "Nhóm Quản Lý", account1, "23/08/2021", accountQuanLy, "24/08/2021");
		Group groupGiaoDuc = new Group(3, "Nhóm Giáo Dục", account2, "23/08/2021", accountGiaoDuc, "24/08/2021");
		Group groupCSKH = new Group(4, "Nhóm Chăm Sóc Khách Hàng", account2, "23/08/2021", accountCSKH, "24/08/2021");
		// ADD OBJECT TO TYPEQUESTION
		TypeQuestion tracNghiem = new TypeQuestion(1, "Dạng Trắc Nghiệm");
		TypeQuestion tuLuan = new TypeQuestion(2, "Dạng Tự Luận");
		// ADD OBJECT TO CATEGORY QUESTION
		CategoryQuestion java = new CategoryQuestion(1, categoryName.JAVA);
		CategoryQuestion net = new CategoryQuestion(2, categoryName.NET);
		CategoryQuestion sql = new CategoryQuestion(3, categoryName.SQL);
		CategoryQuestion postman = new CategoryQuestion(4, categoryName.POSTMAN);
		CategoryQuestion ruby = new CategoryQuestion(5, categoryName.RUBY);
		// ADD OBJECT TO QUESTION
		Question javaQuestion1 = new Question(1, "Em hiểu gì về Java", java, tracNghiem, account4, "25/08/2021");
		Question javaQuestion2 = new Question(2, "Cách tạo CLASS trong Java ", java, tuLuan, account4, "25/08/2021");
		Question netQuestion = new Question(3, "Em hiểu gì về ngôn ngữ .NET", net, tracNghiem, account5, "25/08/2021");
		Question sqlQuestion1 = new Question(4, "Em hiểu gì về mySQL", sql, tracNghiem, account5, "25/08/2021");
		Question sqlQuestion2 = new Question(5, "Cách tạo Procedure trong mySQL", sql, tuLuan, account4, "25/08/2021");
		Question postmanQuestion1 = new Question(6, "Em hiểu gì về ngôn ngữ Postman", postman, tuLuan, account5,
				"25/08/2021");
		Question postmanQuestion2 = new Question(7, "Tìm hiểu chung về Postman", postman, tuLuan, account5,
				"25/08/2021");
		Question rubyQuestion = new Question(8, "Em hiểu gì về ngôn ngữ Ruby", ruby, tuLuan, account4, "25/08/2021");

		// ARRAY SYSTEM QUESTION
		Question[] javaSystem = new Question[50];
		javaSystem[0] = javaQuestion1;
		javaSystem[1] = javaQuestion2;
		Question[] netSystem = new Question[20];
		netSystem[0] = netQuestion;
		Question[] sqlSystem = new Question[30];
		sqlSystem[0] = sqlQuestion1;
		sqlSystem[1] = sqlQuestion2;
		Question[] postmanSystem = new Question[20];
		postmanSystem[0] = postmanQuestion1;
		postmanSystem[1] = postmanQuestion2;
		Question[] rubySystem = new Question[20];
		rubySystem[0] = rubyQuestion;
		// ADD OBJECT TO ANSWER
		Answer javaAnswer = new Answer(1, "Đáp án về Java", javaSystem, AnswerRightWrong.RIGHT);
		Answer netAnswer = new Answer(2, "Đáp án về .NET", netSystem, AnswerRightWrong.RIGHT);
		Answer sqlAnswer = new Answer(3, "Đáp án về mySQL", sqlSystem, AnswerRightWrong.RIGHT);
		Answer postmanAnswer = new Answer(4, "Đáp án về POSTMAN", postmanSystem, AnswerRightWrong.RIGHT);
		Answer rubyAnswer = new Answer(5, "Đáp án về Ruby", rubySystem, AnswerRightWrong.RIGHT);
		// ADD OBJECT TO EXAM
		Exam finalExam1 = new Exam(1, "FinalEX001", "Đề kết thúc môn Java", java, "180 phút", account5, "26/08/2021",
				javaSystem);
		Exam finalExam2 = new Exam(2, "FinalEX002", "Đề kết thúc môn .NET", net, "180 phút", account5, "26/08/2021",
				netSystem);
		Exam finalExam3 = new Exam(3, "FinalEX003", "Đề kết thúc môn mySQL", sql, "180 phút", account5, "26/08/2021",
				sqlSystem);
		Exam finalExam4 = new Exam(4, "FinalEX004", "Đề kết thúc môn Postman", postman, "180 phút", account5,
				"26/08/2021", postmanSystem);
		Exam finalExam5 = new Exam(5, "FinalEX005", "Đề kết thúc môn Ruby", ruby, "180 phút", account5, "26/08/2021",
				rubySystem);

		Exam check15Minutes = new Exam(6, "C15M001", "Kiểm tra 15p Java", java, "15 phút", account4, "26/08/2021",
				javaQuestion1);
/*
		// PRINT AT LEAST 1 VALUE OF EACH OBJECT
		// PRINT 1 DEPARTMENT
		System.out.println(phongGiamDoc + "\n");
		
		// PRINT 1 POSITION
		System.out.println(giamDoc+ "\n");
		// PRINT 1 ACCOUNT
		System.out.println(account1+ "\n");
		// PRINT 1 GROUP
		System.out.println(groupHoiDong+ "\n");
		// PRINT 1 TYPEQUESTION
		System.out.println(tracNghiem+ "\n");
		// PRINT 1 CATEGORYQUESTION
		System.out.println(java+ "\n");
		// PRINT 1 QUESTION
		System.out.println(javaQuestion1+ "\n");
		// PRINT 1 ANSWER
		System.out.println(javaAnswer+ "\n");
		// PRINT 1 EXAM
		System.out.println(finalExam1+ "\n");
		
*/
		int idAccount;
		Scanner scanner =new Scanner(System.in);
		System.out.println("Điền vào id nhân viên để tìm thông tin : ");
		idAccount = scanner.nextInt();
		// Question 1 
		switch (idAccount) {
			case 1:
				if(account1.department == null ) {
				System.out.println("Nhân viên này chưa có phòng ban");
				}
			else {
				System.out.println("Phòng ban của nhân viên này là : "+ account1.department);
				{
			}
				}
			break;
		case 2:
			if(account2.department == null ) {
				System.out.println("Nhân viên này chưa có phòng ban");
				}
			else {
				System.out.println("Phòng ban của nhân viên này là : "+ account2.department);
				{
			}
				}
			break;
		
		case 3:
					if(account3.department == null ) {
						System.out.println("Nhân viên này chưa có phòng ban");
					}
					else {
						System.out.println("Phòng ban của nhân viên này là : "+ account3.department);
						break;}
		case 4:
						if(account4.department == null ) {
							System.out.println("Nhân viên này chưa có phòng ban");
						}
						else {
							System.out.println("Phòng ban của nhân viên này là : "+ account4.department);
							break;
		}
	
		}

		/*
		 * // CREATE ARRAY ALL ACCOUNT Account[] mangAccounts = new Account[7];
		 * mangAccounts[0] = account1; mangAccounts[1] = account2; mangAccounts[2] =
		 * account3; mangAccounts[3] = account4; mangAccounts[4] = account5;
		 * mangAccounts[5] = account6; mangAccounts[6] = account7; // PRINT ALL ACCOUNT
		 * System.out.println("Mang cac Account : "); for (int i = 0; i <
		 * mangAccounts.length; i++) { System.out.println(mangAccounts[i]); } // SỐ
		 * ACCOUNT System.out.println("Số Account là :");
		 * System.out.println(mangAccounts.length);
		 */

	}
}

