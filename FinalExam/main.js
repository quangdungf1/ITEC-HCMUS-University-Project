console.log("welcome to ITEC final store");
/* Here are the endpoints you need to hit */
/* https://dummyjson.com/products/  for all products*/
/* https://dummyjson.com/products/category/smartphones an example of a filter category (choose 4-5) */

displayDefault();

async function getProducts(){
    const response = await fetch(`https://dummyjson.com/products?limit=6`)
    .then((res)=>res.json())
    .then((data)=>data);
    console.log(response);
    return response;
}
async function getCategories(value){
    const response = await fetch(`https://dummyjson.com/products/category/${value}?limit=4`)
    .then((res)=>res.json())
    .then((data)=>data)
    console.log(response);
    return response;
} 

/* call your start up functions here */


/* declare your global vars here */
let phone = document.querySelector(".smartphones");
let laptop = document.querySelector(".laptops");
let skincare = document.querySelector(".skincare");
let furniture = document.querySelector(".furniture");
let cartTotal= document.querySelector(".cart-total");

// let purchase= document.getElementById("purchase-btn");
// purchase.addEventListener("click",(e)=>{
//     console.log('hel;loo may cunf')

// })

/* add your event listeners here */
phone.addEventListener("click",(e)=>{
    e.preventDefault();
    displayProducts("smartphones");
})
laptop.addEventListener("click",(e)=>{
    e.preventDefault();
    displayProducts("laptops")
})
skincare.addEventListener("click",(e)=>{
    e.preventDefault();
    displayProducts("skincare")
})
furniture.addEventListener("click",(e)=>{
    e.preventDefault();
    displayProducts("home-decoration")
})

/* create script functions here (remember to use async + await where needed) */
async function displayDefault(){
    let response = await getProducts();

console.log(response);
console.log(response.products.length);
console.log(Object.values(response.products[0]));
let output = "";

for(let i=0;i<response.products.length;i++){
    output += `
    <div class="col-md-4 mt-4">
          <div class="product">
            <div class="product-details border border-black">
            <img src="${Object.values(response.products[i].images)[0]}" alt="Product Image">
              <h3 class="product-title mt-2">${response.products[i].title}</h3>
              
              <p class="product-price">$${response.products[i].price}</p>
              <div class="product-buttons">
                <button type="button" class="btn btn-outline-primary id="readmore-btn"">Read More</button>
                <button type="button" class="btn btn-primary" id="purchase-btn"><i class="fa fa-plus purchase"></i> Purchase</button>
              </div>
            </div>
          </div>
        </div>
    `;
}
document.querySelector(".product-output").innerHTML = output;
buying();
}
async function displayProducts(value){
        let values = await getCategories(value);
    
    console.log(values);
    console.log(values.products.length);
    console.log(Object.values(values.products[0]));
    let output = "";
    
    for(let i=0;i<values.products.length;i++){
        output += `
        <div class="col-md-3">
              <div class="product">
                <div class="product-details border border-black">
                <img src="${Object.values(values.products[i].images)[0]}" alt="Product Image">
                  <h3 class="product-title mt-2">${values.products[i].title}</h3>
                  
                  <p class="product-price">$${values.products[i].price}</p>
                  <div class="product-buttons">
                    <button type="button" class="btn btn-outline-primary" id="readmore-btn">Read More</button>
                    <button type="button" class="btn btn-primary" id="purchase-btn"><i class="fa fa-plus"></i> Purchase</button>
                  </div>
                </div>
              </div>
            </div>
        `;
    }
    document.querySelector(".product-output").innerHTML = output;
    buying();
}


let total=0;
function buying(){
    let purchaseBtns = document.querySelectorAll("button[id^=purchase-btn]");

    purchaseBtns.forEach((btn) => {
      btn.addEventListener("click", (event) => {
        total += 1;
      console.log(total);
      cartTotal.textContent = total;
      });
    });
}
function readmoreBut(){
    let readmoreBtns = document.querySelectorAll("button[id^=readmore-btn]");

    readmoreBtns.forEach((btn) => {
      btn.addEventListener("click", (event) => {
       
      console.log(total);
      
      });
    });
}
function storeItemList(itemlist) {
    localStorage.setItem("itemlist", JSON.stringify(itemlist));
}
// 
