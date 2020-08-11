import { fetchWithToken } from "../utils/fetch_with_token";

const initNewRestaurantModal = () => {
    const newRestaurantForm = document.querySelector("#new_restaurant");
    
    if (newRestaurantForm) {
        const nameInput = newRestaurantForm.querySelector("#restaurant_name");
        const addressInput = newRestaurantForm.querySelector("#restaurant_address");
        const phoneInput = newRestaurantForm.querySelector("#restaurant_phone_number");
        const categoryInput = newRestaurantForm.querySelector("#restaurant_category");
        const submitBtn = newRestaurantForm.querySelector('input[type="submit"]');
        const errorDisplay = newRestaurantForm.querySelector('#error_display');

        newRestaurantForm.addEventListener("submit", (e) => {
            e.preventDefault();
    
            fetchWithToken("/restaurants", {
                method: "POST",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    restaurant: {
                        name: nameInput.value,
                        address: addressInput.value,
                        phone_number: phoneInput.value,
                        category: categoryInput.value
                    }
                })
            })
                .then(response => response.json())
                .then((data) => {
                    if (data.id) {
                        window.location.href = `/restaurants/${data.id}`;
                    } else {
                        submitBtn.disabled = true;
                        let html = "";
                        Object.keys(data.errors).forEach((key) => {
                            data.errors[key].forEach((message) => {
                                html += `<li>${key} ${message}</li>`;
                            })
                        })
                        errorDisplay.innerHTML = html;
                        newRestaurantForm.addEventListener('keyup', () => {
                            submitBtn.disabled = false;
                        })
                    }
                });
        })
    }
}

export { initNewRestaurantModal }