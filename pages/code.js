
  const menuIcon = document.querySelector('.menu-icon');
  const menu = document.querySelector('.menu-navegacao');

  menuIcon.addEventListener('click', () => {
    if (menu.style.display === 'flex') {
      menu.style.display = 'none';
    } else {
      menu.style.display = 'flex';
    }
  });

