document.addEventListener("DOMContentLoaded", function () {
	const addAvailabilityBtn = document.getElementById("addAvailability");
	const saveAvailabilityBtn = document.getElementById("saveAvailability");
	const editAvailabilityBtn = document.getElementById("editAvailability");
	const availabilityDiv = document.getElementById("availability");

	addAvailabilityBtn.addEventListener("click", addAvailability);
	saveAvailabilityBtn.addEventListener("click", saveAvailability);
	editAvailabilityBtn.addEventListener("click", editAvailability);
	availabilityDiv.addEventListener("click", removeAvailability);
	availabilityDiv.addEventListener("change", checkInputCompleteness);

	function addAvailability() {
		const newAvailability = document.createElement("div");
		newAvailability.classList.add("availability-day");

		const daySelect = document.createElement("select");
		daySelect.classList.add("day-select");
		daySelect.innerHTML = `
      <option value="monday">Monday</option>
      <option value="tuesday">Tuesday</option>
      <option value="wednesday">Wednesday</option>
      <option value="thursday">Thursday</option>
      <option value="friday">Friday</option>
      <option value="saturday">Saturday</option>
      <option value="sunday">Sunday</option>
    `;

		const startTimeLabel = document.createElement("label");
		startTimeLabel.setAttribute("for", "startTime");
		startTimeLabel.textContent = "Start Time";

		const startTimeInput = document.createElement("input");
		startTimeInput.setAttribute("type", "time");
		startTimeInput.classList.add("startTime");
		startTimeInput.setAttribute("name", "startTime");
		startTimeInput.setAttribute("step", "1"); // 24-hour format

		const endTimeLabel = document.createElement("label");
		endTimeLabel.setAttribute("for", "endTime");
		endTimeLabel.textContent = "End Time";

		const endTimeInput = document.createElement("input");
		endTimeInput.setAttribute("type", "time");
		endTimeInput.classList.add("endTime");
		endTimeInput.setAttribute("name", "endTime");
		endTimeInput.setAttribute("step", "1"); // 24-hour format

		const removeBtn = document.createElement("button");
		removeBtn.classList.add("removeAvailability");
		removeBtn.textContent = "Remove";

		newAvailability.appendChild(daySelect);
		newAvailability.appendChild(startTimeLabel);
		newAvailability.appendChild(startTimeInput);
		newAvailability.appendChild(endTimeLabel);
		newAvailability.appendChild(endTimeInput);
		newAvailability.appendChild(removeBtn);

		availabilityDiv.appendChild(newAvailability);

		removeBtn.addEventListener("click", removeAvailability);
	}

	function removeAvailability(e) {
		if (e.target.classList.contains("removeAvailability")) {
			const availabilityItem = e.target.closest(".availability-day");
			if (availabilityItem) {
				availabilityItem.remove();
			}
		}
	}

	function saveAvailability() {
		const availabilityBlock = document.getElementById("availability");
		addAvailabilityBtn.style.display = "none";
		saveAvailabilityBtn.style.display = "none";
		editAvailabilityBtn.style.display = "inline-block";
		const appointmentDuration = document.getElementById(
			"appointmentDuration"
		).value;

		const availabilityDays =
			document.getElementsByClassName("availability-day");
		const availabilityData = [];

		for (let i = 0; i < availabilityDays.length; i++) {
			const daySelect = availabilityDays[i].querySelector(".day-select");
			const startTimeInput = availabilityDays[i].querySelector(".startTime");
			const endTimeInput = availabilityDays[i].querySelector(".endTime");

			const availability = {
				day: daySelect.value,
				startTime: startTimeInput.value,
				endTime: endTimeInput.value,
			};

			availabilityData.push(availability);
		}

		const availabilityMap = {};
		availabilityData.forEach((availability) => {
			const { day, startTime, endTime } = availability;
			if (!availabilityMap[day]) {
				availabilityMap[day] = [];
			}
			availabilityMap[day].push({ startTime, endTime });
		});

		const availabilityMapDiv = document.getElementById("availabilityMap");
		availabilityMapDiv.innerHTML = "";
		Object.entries(availabilityMap).forEach(([day, ranges]) => {
			const dayDiv = document.createElement("div");
			dayDiv.textContent = day.charAt(0).toUpperCase() + day.slice(1) + ": ";
			ranges.forEach((range, index) => {
				const { startTime, endTime } = range;
				dayDiv.textContent += `${startTime}-${endTime}`;
				if (index !== ranges.length - 1) {
					dayDiv.textContent += ", ";
				}
			});
			availabilityMapDiv.appendChild(dayDiv);
		});

		const successMessage = document.getElementById("success-message");
		successMessage.style.display = "block";
		availabilityBlock.style.display = "none";
	}

	function editAvailability() {
		addAvailabilityBtn.style.display = "inline-block";
		saveAvailabilityBtn.style.display = "inline-block";
		editAvailabilityBtn.style.display = "none";

		const availabilityMapDiv = document.getElementById("availabilityMap");
		availabilityMapDiv.innerHTML = "";
		const successMessage = document.getElementById("success-message");
		successMessage.style.display = "none";
	}

	function checkInputCompleteness() {
		const availabilityDays =
			document.getElementsByClassName("availability-day");
		let isInputComplete = true;

		for (let i = 0; i < availabilityDays.length; i++) {
			const startTimeInput = availabilityDays[i].querySelector(".startTime");
			const endTimeInput = availabilityDays[i].querySelector(".endTime");

			if (startTimeInput.value === "" || endTimeInput.value === "") {
				isInputComplete = false;
				break;
			}
		}

		addAvailabilityBtn.disabled = !isInputComplete;
		saveAvailabilityBtn.disabled = !isInputComplete;
	}
	checkInputCompleteness();
});
