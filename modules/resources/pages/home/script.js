// Mocked user data
const users = [
	{
		name: "John Doe",
		email: "john@example.com",
		userType: "doctor",
		password: "password1",
	},
	{
		name: "Jane Smith",
		email: "jane@example.com",
		userType: "patient",
		password: "password2",
	},
];

// Elements
const loginContainer = document.getElementById("login-container");
const signinContainer = document.getElementById("signin-container");
const emailInput = document.getElementById("email");
const passwordInput = document.getElementById("password");
const signinEmailInput = document.getElementById("signin-email");
const nameInput = document.getElementById("name");
const userTypeSelect = document.getElementById("user-type");
const loginBtn = document.getElementById("login-btn");
const signinBtn = document.getElementById("signin-btn");
const signinConfirmBtn = document.getElementById("signin-confirm-btn");
const backBtn = document.getElementById("back-btn");

// Event listeners
loginBtn.addEventListener("click", login);
signinBtn.addEventListener("click", showSigninForm);
signinConfirmBtn.addEventListener("click", signin);
backBtn.addEventListener("click", showLoginForm);

// Function to check if the provided email and password match a user
function login() {
	const email = emailInput.value;
	const password = passwordInput.value;

	const user = users.find(
		(user) => user.email === email && user.password === password
	);

	if (user) {
		redirectToDashboard(user.userType);
	} else {
		alert("Invalid email or password. Please try again.");
	}
}

// Function to show the sign-in form
function showSigninForm() {
	loginContainer.style.display = "none";
	signinContainer.style.display = "block";
}

// Function to show the login form
function showLoginForm() {
	signinContainer.style.display = "none";
	loginContainer.style.display = "block";
}

// Function to sign in a new user
function signin() {
	const name = nameInput.value;
	const email = signinEmailInput.value;
	const userType = userTypeSelect.value;

	// Check if the required fields are filled
	if (name && email && userType) {
		// Generate a random password for the new user
		const password = generateRandomPassword();

		// Create a new user object
		const newUser = { name, email, userType, password };

		// Add the new user to the users array
		users.push(newUser);

		alert("Sign-in successful! Your password is: " + password);

		// Clear the sign-in form inputs
		nameInput.value = "";
		signinEmailInput.value = "";
		userTypeSelect.value = "";

		// Show the login form
		showLoginForm();
	} else {
		alert("Please fill in all the required fields.");
	}
}

// Function to generate a random password
function generateRandomPassword() {
	const characters =
		"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	let password = "";

	for (let i = 0; i < 8; i++) {
		password += characters.charAt(
			Math.floor(Math.random() * characters.length)
		);
	}

	return password;
}

// Function to redirect to the appropriate dashboard based on user type
function redirectToDashboard(userType) {
	if (userType === "doctor") {
		window.location.href = "../doctor/index.html";
	} else if (userType === "patient") {
		window.location.href = "../patient/index.html";
	}
}
