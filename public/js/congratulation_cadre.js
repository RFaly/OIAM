function addDiamond(){
	var modal = document.getElementById("modal-unique")
	var nb = Math.random() * 40;
	const diamond = document.createElement('div');
	const image = document.createElement('img');


	image.src = '/image/Vector-24.png';
	diamond.style.left = Math.random() * 100 +"vw";
	diamond.style.animationDuration = Math.random() * 2 + 3 + "s";
	diamond.classList.add("diamond");
	diamond.style.width = Math.random(5) * nb + "px";
	diamond.style.height = Math.random(5) * nb + "px";

	modal.appendChild(diamond);
	diamond.appendChild(image);

	setTimeout(() => {
		diamond.remove();
	}, 5000);
}

var interval = Math.random() * 800;

setInterval(addDiamond, interval);




