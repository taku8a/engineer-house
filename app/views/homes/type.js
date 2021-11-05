const typewriter = (param) => {
  let el = document.querySelector(param.el);
  let speed = param.speed;
  let string = param.string.split("");

   window.setTimeout(function () {
      string.forEach((char, index) => {
        setTimeout(() => {
          el.textContent += char;
        }, speed * index);
    });
  }, 500);
};

typewriter({
  el: "#js-typewriter", //要素
  string: "タイピング風に文字が出力されます。", //文字
  speed: 80 //速度
});