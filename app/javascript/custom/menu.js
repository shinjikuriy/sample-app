// メニュー操作


// トグルリスナーを追加する関数
function addToggleListner(selected_id, menu_id, toggle_class) {
  let selected_element = document.querySelector(`#${selected_id}`);
  selected_element.addEventListener("click", function(event) {
    event.preventDefault();
    let menu = document.querySelector(`#${menu_id}`);
    menu.classList.toggle(toggle_class);
  });
}

// クリックをリッスンするトグルリスナーを追加
document.addEventListener("turbo:load", function() {
  addToggleListner("hamburger", "navbar-menu", "collapse");
  addToggleListner("account", "dropdown-menu", "active");
});
