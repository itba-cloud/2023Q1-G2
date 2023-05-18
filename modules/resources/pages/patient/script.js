document.addEventListener("DOMContentLoaded", () => {
	const specialtySelect = document.getElementById("specialty");
	const doctorSelect = document.getElementById("doctor");
	const daySelect = document.getElementById("day");
	const timeSelect = document.getElementById("time");
	const takeAppointmentButton = document.getElementById("takeAppointment");
	const appointmentInfoContainer = document.getElementById("appointmentInfo");
	const confirmButton = document.getElementById("confirm");
	const changeButton = document.getElementById("change");

	specialtySelect.addEventListener("change", updateDoctors);
	doctorSelect.addEventListener("change", updateDays);
	daySelect.addEventListener("change", updateTime);
	takeAppointmentButton.addEventListener("click", showAppointmentInfo);
	confirmButton.addEventListener("click", confirmAppointment);
	changeButton.addEventListener("click", resetSelection);

	let appointmentData = {
		doctorId: "",
		day: "",
		time: "",
	};

	const doctorsBySpecialty = {
		cardiology: [
			{
				id: 1,
				name: "Dr. John Smith",
				durationOfAppointment: 30,
				availability: {
					Monday: [
						{ start: "09:00", end: "13:00" },
						{ start: "14:00", end: "18:00" },
					],
					Tuesday: [{ start: "09:00", end: "13:00" }],
					Wednesday: [
						{ start: "09:00", end: "13:00" },
						{ start: "14:00", end: "18:00" },
					],
				},
			},
			{
				id: 2,
				name: "Dr. Sarah Johnson",
				durationOfAppointment: 20,
				availability: {
					Monday: [{ start: "09:00", end: "13:00" }],
					Tuesday: [{ start: "14:00", end: "18:00" }],
					Thursday: [{ start: "09:00", end: "13:00" }],
				},
			},
		],
		dermatology: [
			{
				id: 3,
				name: "Dr. Michael Davis",
				durationOfAppointment: 40,
				availability: {
					Monday: [{ start: "09:00", end: "13:00" }],
					Tuesday: [
						{ start: "09:00", end: "13:00" },
						{ start: "14:00", end: "18:00" },
					],
					Wednesday: [{ start: "09:00", end: "13:00" }],
				},
			},
			{
				id: 4,
				name: "Dr. Emily Wilson",
				durationOfAppointment: 10,
				availability: {
					Monday: [{ start: "14:00", end: "18:00" }],
					Tuesday: [
						{ start: "09:00", end: "13:00" },
						{ start: "14:00", end: "18:00" },
					],
					Thursday: [{ start: "09:00", end: "13:00" }],
				},
			},
		],
		orthopedics: [
			{
				id: 5,
				name: "Dr. Robert Anderson",
				durationOfAppointment: 15,
				availability: {
					Tuesday: [
						{ start: "09:00", end: "13:00" },
						{ start: "14:00", end: "18:00" },
					],
					Thursday: [{ start: "09:00", end: "13:00" }],
					Friday: [{ start: "14:00", end: "18:00" }],
				},
			},
			{
				id: 6,
				name: "Dr. Jennifer Brown",
				durationOfAppointment: 20,
				availability: {
					Monday: [{ start: "09:00", end: "13:00" }],
					Wednesday: [
						{ start: "09:00", end: "13:00" },
						{ start: "14:00", end: "18:00" },
					],
					Thursday: [{ start: "09:00", end: "13:00" }],
				},
			},
		],
		pediatrics: [
			{
				id: 7,
				name: "Dr. David Miller",
				durationOfAppointment: 30,
				availability: {
					Monday: [
						{ start: "09:00", end: "01:00" },
						{ start: "14:00", end: "18:00" },
					],
					Tuesday: [{ start: "09:00", end: "01:00" }],
					Wednesday: [{ start: "09:00", end: "01:00" }],
					Friday: [{ start: "09:00", end: "01:00" }],
				},
			},
			{
				id: 8,
				name: "Dr. Jessica Williams",
				durationOfAppointment: 40,
				availability: {
					Tuesday: [{ start: "14:00", end: "18:00" }],
					Thursday: [
						{ start: "09:00", end: "01:00" },
						{ start: "14:00", end: "18:00" },
					],
					Friday: [{ start: "09:00", end: "01:00" }],
				},
			},
		],
	};

	function updateDoctors() {
		const specialty = specialtySelect.value;
		const doctors = doctorsBySpecialty[specialty] || [];

		doctorSelect.innerHTML = "<option value=''>Select Doctor</option>";
		daySelect.innerHTML = "<option value=''>Select Day</option>";
		timeSelect.innerHTML = "<option value=''>Select Time</option>";

		if (doctors.length > 0) {
			doctorSelect.disabled = false;

			for (const doctor of doctors) {
				const option = document.createElement("option");
				option.value = doctor.id;
				option.textContent = doctor.name;
				doctorSelect.appendChild(option);
			}
		} else {
			doctorSelect.disabled = true;
		}
	}

	function updateDays() {
		const doctorId = doctorSelect.value;
		const doctor = getDoctorById(doctorId);

		if (doctor) {
			const availability = Object.keys(doctor.availability);
			daySelect.innerHTML = "<option value=''>Select Day</option>";

			for (const day of availability) {
				const option = document.createElement("option");
				option.value = day;
				option.textContent = day;
				daySelect.appendChild(option);
			}

			daySelect.disabled = false;
			timeSelect.innerHTML = "<option value=''>Select Time</option>";
		} else {
			daySelect.innerHTML = "<option value=''>Select Day</option>";
			daySelect.disabled = true;
			timeSelect.innerHTML = "<option value=''>Select Time</option>";
		}
	}

	function updateTime() {
		const selectedDoctorId = doctorSelect.value;
		const selectedDay = daySelect.value;

		if (selectedDoctorId && selectedDay) {
			const selectedDoctor = getDoctorById(selectedDoctorId);
			const availability = selectedDoctor.availability[selectedDay];
			const durationOfAppointment = selectedDoctor.durationOfAppointment;

			const timeSelector = document.getElementById("time");
			timeSelector.innerHTML = "";

			for (let i = 0; i < availability.length; i++) {
				const { start, end } = availability[i];
				const startTime = parseTimeString(start);
				const endTime = parseTimeString(end);

				let currentTime = startTime;

				while (currentTime <= endTime) {
					const option = document.createElement("option");
					option.value = formatTimeString(currentTime);
					option.textContent = formatTimeString(currentTime);
					timeSelector.appendChild(option);

					currentTime.setMinutes(
						currentTime.getMinutes() + durationOfAppointment
					);
				}
			}

			timeSelector.disabled = false;
		} else {
			clearTimeSelector();
			disableTimeSelector();
		}
	}

	function parseTimeString(timeString) {
		const [hours, minutes] = timeString.split(":").map(Number);
		const currentDate = new Date();
		currentDate.setHours(hours);
		currentDate.setMinutes(minutes);
		currentDate.setSeconds(0);
		currentDate.setMilliseconds(0);
		return currentDate;
	}

	function formatTimeString(date) {
		const hours = padZero(date.getHours());
		const minutes = padZero(date.getMinutes());
		return `${hours}:${minutes}`;
	}

	function padZero(num) {
		return num.toString().padStart(2, "0");
	}

	function clearTimeSelector() {
		const timeSelector = document.getElementById("time");
		timeSelector.innerHTML = "";
	}

	function disableTimeSelector() {
		const timeSelector = document.getElementById("time");
		timeSelector.disabled = true;
	}

	function showAppointmentInfo() {
		const selectedDoctorId = doctorSelect.value;
		const selectedDay = daySelect.value;
		const selectedTime = timeSelect.value;
		const selectedDoctor = getDoctorById(selectedDoctorId);

		if (selectedDoctor && selectedDay && selectedTime) {
			const durationOfAppointment = selectedDoctor.durationOfAppointment;
			const appointmentDate = getAppointmentDate(selectedDay);
			const formattedDate = formatDate(appointmentDate);
			const formattedTime = selectedTime;

			appointmentData = {
				doctorId: selectedDoctorId,
				day: selectedDay,
				time: selectedTime,
			};

			const appointmentInfo = `You have selected the following appointment:<br><br>
        <p><strong>Doctor: ${selectedDoctor.name}<br></p>
        <p><strong>Date: ${formattedDate}<br></p>
        <p><strong>Time: ${formattedTime}<br></p>
        <p><strong>Duration: ${durationOfAppointment} minutes</p>`;

			appointmentInfoContainer.innerHTML = appointmentInfo;
			const confirmButton = document.getElementById("confirm");
			const changeButton = document.getElementById("change");

			confirmButton.style.display = "block";
			changeButton.style.display = "block";
		} else {
			appointmentData = {
				doctorId: "",
				day: "",
				time: "",
			};
			appointmentInfoContainer.innerHTML =
				"Please select all appointment details.";
		}
	}

	function confirmAppointment() {
		if (
			appointmentData.doctorId &&
			appointmentData.day &&
			appointmentData.time
		) {
			appointmentData = {
				doctorId: "",
				day: "",
				time: "",
			};

			appointmentInfoContainer.innerHTML = "Appointment successfully taken!";
		} else {
			appointmentInfoContainer.innerHTML = "No appointment data available.";
		}
	}

	function resetSelection() {
		appointmentData = {
			doctorId: "",
			day: "",
			time: "",
		};

		specialtySelect.value = "";
		doctorSelect.innerHTML = "<option value=''>Select Doctor</option>";
		doctorSelect.disabled = true;
		daySelect.innerHTML = "<option value=''>Select Day</option>";
		daySelect.disabled = true;
		timeSelect.innerHTML = "<option value=''>Select Time</option>";
		timeSelect.disabled = true;
		appointmentInfoContainer.innerHTML = "";
	}

	function getAppointmentDate(selectedDay) {
		const currentDate = new Date();
		const lastDayOfMonth = new Date(
			currentDate.getFullYear(),
			currentDate.getMonth() + 1,
			0
		);

		while (
			currentDate.getDay() !== getDayIndex(selectedDay) ||
			currentDate > lastDayOfMonth
		) {
			currentDate.setDate(currentDate.getDate() + 1);
		}

		return currentDate;
	}

	function getDayIndex(day) {
		const daysOfWeek = [
			"Sunday",
			"Monday",
			"Tuesday",
			"Wednesday",
			"Thursday",
			"Friday",
			"Saturday",
		];
		return daysOfWeek.indexOf(day);
	}

	function formatDate(date) {
		const day = date.getDate();
		const month = date.getMonth() + 1;
		const year = date.getFullYear();

		return `${day}/${month}/${year}`;
	}

	function getDoctorById(id) {
		const specialties = Object.values(doctorsBySpecialty);
		for (const doctors of specialties) {
			const doctor = doctors.find((doc) => doc.id.toString() === id);
			if (doctor) {
				return doctor;
			}
		}
		return null;
	}
});
