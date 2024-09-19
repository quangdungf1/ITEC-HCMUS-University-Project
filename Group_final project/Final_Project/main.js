console.log("JS is running!");
// Declare variables
let search = document.querySelector("input.inputSearch");
let searchBtn = document.querySelector("button.buttonSearch");
let results = document.querySelector(".alert");
let pager = document.querySelector("ul.pagination");

checkklogindata();
const batchTrack = document.getElementById("countries_list");
const getPost = async () => {
  const response = await fetch("http://universities.hipolabs.com/search");
  console.log(response);
  const data = await response.json();
  return data;
};

//Todo: Make the display function target the country then store the results
const displayOption = async () => {
  const options = await getPost();
  const uniqueCountries = new Set();
  //Todo: DISTINCT 
  for (option of options) {
    if (option.country.includes("United States") == false) {
      uniqueCountries.add(option.country);
    }
  }
  for (country of uniqueCountries) {
    const newOption = document.createElement("option");
    newOption.text = country;
    batchTrack.appendChild(newOption);
  }
  //Todo: Declare and make a search function
  let selectOpt = document.querySelector('select');
  selectOpt.addEventListener("click", (e) => {
    e.preventDefault();
    console.log(selectOpt.value);

    searchBtn.addEventListener("click", (event) => {
      event.preventDefault();
      console.log("object");
      let value = search.value;
      console.log(value);
      findResult(value, 0, selectOpt.value);
      //Todo: Automatically replace new pages with old pages
      pager.addEventListener("click", (event) => {
        event.preventDefault();
        let targ = event.target;
        console.log(targ);
        if (targ.classList.contains("pager-number")) {
          let offset = targ.getAttribute("data-offset");
          findResult(search.value, offset, selectOpt.value);
        }
      })
    })
  });

};
displayOption(); 



// Functions
async function findResult(value, offset, nameAPI) {

  //! filter is looking for || map is leak all
  let schools = await getAPI(nameAPI);
  let result = schools.filter((school) => {
    if (school.name.includes(value) || school.country.includes(value)) {
      return school;
    }
  });
  let countResult = result.length;
  results.textContent = `${countResult} result(s) Found!`;
  results.classList.add("active");
  //! Beware: Change dataLimit will change the results output
  const dataLimit = 30;
  outputResults(result, offset, dataLimit);
  outputPagers(result, dataLimit);
}

async function outputResults(value, pageNumber, dataLimit) {
  pageNumber = parseInt(pageNumber) + 1;
  let number = 0;
  let arr = (number + 1) * dataLimit - 1;
  if (pageNumber > 1) {
    number = pageNumber * dataLimit - dataLimit;
    arr = pageNumber * dataLimit - 1;
  }
  let output = "";
  console.log(number);
  console.log(arr);
  for (let i = number; i <= value.length; i++) {
    if (i <= arr) {
      if (i < value.length) {
        console.log(`Sparkle ${i}`);
        console.log(value[i]);
        output += `
                <div class="card p-3 d-flex flex-column gap-1 col-lg-3 col-md-4">
                    <h3>${value[i].name}</h3>
                    <div>
                        <h5>Country: ${value[i].country}</h5>
                        <a href="${value[i].web_pages}" target="_blank" onclick="event.preventDefault(); window.open(this.href);">Link</a>
                     </div>
                </div>`;
      }
    }
  }
  document.querySelector(".search-output").innerHTML = output;
}

async function outputPagers(value, number) {
  let numPages = Math.ceil(value.length / number);
  let previous = document.querySelector(".pagination li.previous");

  let output = "";
  for (let i = 0; i < numPages; i++) {
    let pageNum = i + 1;
    let active = "";
    if (i == 0) {
      active = "active";
    }
    // output += `<li class="page-item ${active}"><a class="page-link pager-number"  data-offset="${i}" href="#">${pageNum}</a></li>`;
    output += `<li class="page-item"><a class="page-link pager-number"  data-offset="${i}" href="#">${pageNum}</a></li>`;
  }
  document.querySelector(".pagination").innerHTML = output;
}

// API

//Todo: Input value to get the API
async function getAPI(name) {
  let response = await fetch(`http://universities.hipolabs.com/search?country=${name}`)
    .then((res) => res.json())
    .then((data) => data);
  return response;
}

function login(val) {
  let output = "";
  output += `
  <li type="button" data-target="#" id="username_display">
      ${val.img} - ${val.user}
  </li>
  <li type="button" data-target="#" id="logout_button"><p>Log out</p></li>
  `
  document.querySelector("div#login-signup ul").innerHTML = output;
}
function checkklogindata() {
  const users = JSON.parse(localStorage.getItem('users'));
  let id = null;
  for (const key in users) {
    if (users[key].login_data === 'true') {
      id = key;
      break;
    }
  }
  if (id != null) {
    let newLogin = {
      user: users[id].username,
      img: `<img class="peguin" src="images/CanhCut.jpg" alt="">`
    }
    login(newLogin);
  }

}
//log out button clicked
let logout = document.getElementById("logout_button");
logout.addEventListener("click", (event) => {
  event.preventDefault();
  const user = JSON.parse(localStorage.getItem('users'));
  let id = null;
  for (const key in user) {
    if (user[key].login_data === 'true') {
      id = key;
      break;
    }
  }
  if (id != null) {
    let null_atr = '';
    user[id].login_data = null_atr;
    localStorage.setItem('users', JSON.stringify(user));
    alert('You are logging out. Thank you for using our service.');
    window.location.href = "index.html";
  }
});


$('#demo').pagination({
  dataSource: numPages,
  callback: function(data, pagination) {
      // template method of yourself
      var html = template(data);
      pager.html(html);
  }
})