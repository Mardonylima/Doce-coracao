export default function Navbar() {
  return (
    <header id="header">
      <nav className="navbar">
        <div className="container">
          <a href="index.html" className="navbar-logo">
            <img src="/images/DC_logo.avif" alt="Missão JHS Doce Coração" />
          </a>
          <button className="navbar-toggle" aria-label="Abrir menu" aria-expanded="false" aria-controls="navbar-collapse">
            <span className="navbar-toggle-icon" aria-hidden="true">Menu</span>
          </button>
          <div className="navbar-collapse" id="navbar-collapse">
            <ul className="navbar-nav">
              <li className="nav-item">
                <a className="nav-link" href="#Inicio">
                  Inicio
                </a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="#Sobre-nos">
                  sobre nós
                </a>
              </li>
              <li className="nav-item">
                <div className="dropdown">
                  <a className="dropdown-toggle" aria-haspopup="true" aria-expanded="false">
                    Agenda
                  </a>
                  <div className="dropdown-menu">
                    <a className="dropdown-item" href="#">ação</a>
                    <a className="dropdown-item" href="#">outra ação</a>
                    <a className="dropdown-item" href="#">mais alguma coisa</a>
                  </div>
                </div>
              </li>
              <li className="nav-item">
                <div className="dropdown">
                  <a className="dropdown-toggle" aria-haspopup="true" aria-expanded="false">
                    Comunidade
                  </a>
                  <div className="dropdown-menu">
                    <a className="dropdown-item" href="#">ação</a>
                    <a className="dropdown-item" href="#">outra ação</a>
                    <a className="dropdown-item" href="#">mais alguma coisa</a>
                  </div>
                </div>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="#Contato">
                  Contato
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </header>
  );
}
