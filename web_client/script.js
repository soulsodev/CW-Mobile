const salonsDiv = document.querySelector('#salonsDiv');
const username = document.querySelector('#username');
const password = document.querySelector('#password');
const error = document.querySelector('#error');
const loginForm = document.querySelector('#loginForm');

async function getSalonsConsultation(id) {
    salonsDiv.innerHTML = '';
    const buttonElement = document.createElement('button');
    buttonElement.textContent = 'All';
    buttonElement.onclick = () => getSalons();
    salonsDiv.append(buttonElement);
    const salonsResponse = await fetch(`http://localhost:5000/salons/${id}/consultations`, {
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
    });
    const salons = await salonsResponse.json();
    console.log(salons);
    salons.forEach((salon) => {
        const row = document.createElement('div');
        row.style.display = 'flex';

        const content = document.createElement('div');
        content.innerHTML = salon.service + ' ' + new Date(salon.datetime).toLocaleString() + ' ' + salon.user.email

        row.append(content)
        salonsDiv.append(row);
    })
    if(salons.length === 0){
        const noConsultation =document.createElement('div');
        noConsultation.innerHTML = 'No consultation';
        salonsDiv.append(noConsultation);
    }
    salonsDiv.style.display = 'block';
}

function getAddNewPage(){
    salonsDiv.innerHTML = '';

    const buttonAllElement = document.createElement('button');
    buttonAllElement.textContent = 'All';
    buttonAllElement.onclick = () => getSalons();
    salonsDiv.append(buttonAllElement);

    const nameInput = document.createElement('input');
    nameInput.type = 'text'
    nameInput.placeholder = 'text'
    nameInput.id = 'name'
    const city = document.createElement('input');
    city.type = 'city'
    city.placeholder = 'city'
    city.id = 'city'
    const address = document.createElement('input');
    address.type = 'address'
    address.placeholder = 'address'
    address.id = 'address'

    const addError = document.createElement('div');
    addError.style.color = 'red';
    addError.id = 'addError'

    const buttonElement = document.createElement('button');
    buttonElement.textContent = 'Add new';
    buttonElement.onclick = async() => await createNewSalon();

    salonsDiv.append(nameInput, city, address,buttonElement, addError);
}

async function getSalons() {
    salonsDiv.innerHTML = '';

    const buttonElement = document.createElement('button');
    buttonElement.textContent = 'Add new';
    buttonElement.onclick = () => getAddNewPage();
    salonsDiv.append(buttonElement);

    const salonsResponse = await fetch('http://localhost:5000/salons', {
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
    });
    const salons = await salonsResponse.json();
    console.log(salons);
    salons.forEach((salon) => {
        const row = document.createElement('div');
        row.style.display = 'flex';

        const content = document.createElement('div');
        content.innerHTML = salon.name + ' ' + salon.city + ' ' + salon.address

        const buttonElement = document.createElement('button');
        buttonElement.textContent = 'Consultation';
        buttonElement.onclick = () => getSalonsConsultation(salon.id);

        row.append(content, buttonElement)
        salonsDiv.append(row);
    })
    salonsDiv.style.display = 'block';
}

async function login() {
    const response = await fetch('http://localhost:5000/auth/login', {
        method: 'POST',
        body: JSON.stringify({
            username: username.value,
            password : password.value
        }),
        headers: {
            'Content-Type': 'application/json'
        },
    });
    const data = await response.json();
    console.log(data);
    if (data.status) {
        error.innerHTML = data.message;
        return
    }
    if (!data.isAdmin) {
        error.innerHTML = 'Not enough rights';
        return
    }
    console.log(data.access_token)
    localStorage.setItem('token', data.access_token)
    loginForm.style.display = 'none';
    await getSalons();
}

async function createNewSalon() {
    const address = document.querySelector('#address').value;
    const city = document.querySelector('#city').value;
    const name = document.querySelector('#name').value;
    const addError = document.querySelector('#addError');
    const response = await fetch('http://localhost:5000/salons', {
        method: 'POST',
        body: JSON.stringify({
            address,
            city,
            name,
        }),
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
    });
    const data = await response.json();
    console.log(data);
    if (response.status !== 200 || response.status !== 201) {
        addError.innerHTML = data.message || data.map(error => ' ' + error + ' ');
        return
    }
    await getSalons();
}
