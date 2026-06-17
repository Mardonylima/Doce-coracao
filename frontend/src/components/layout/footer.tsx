export default function Footer() {
  return (
    <footer>
        <footer className="footer">
            <div className="container">

                <div className="footer-grid">

                    <div className="footer-brand">
                        <img src="/images/DC_logo.avif" alt="Missão JHS Doce Coração" className="footer-logo" />
                        <p className="footer-brand-desc">
                            Habitar no Santuário do Doce Coração e ser uma vítima de oblação nos altares esquecidos.
                        </p>
                        <div className="footer-redes">
                            <a href="https://www.instagram.com/docecoracaome/" target="_blank" rel="noopener noreferrer"
                                aria-label="Instagram da Missão JHS Doce Coração" className="footer-rede-link">
                                Instagram
                            </a>
                            <a href="https://wa.me/5583999999999" target="_blank" rel="noopener noreferrer"
                                aria-label="WhatsApp da Missão JHS Doce Coração" className="footer-rede-link">
                                WhatsApp
                            </a>
                        </div>
                    </div>

                    
                    <div className="footer-nav">
                        <h4 className="footer-col-titulo">Navegação</h4>
                        <ul className="footer-links">
                            <li><a href="#inicio">Início</a></li>
                            <li><a href="#sobre-nos">Sobre nós</a></li>
                            <li><a href="#agenda">Agenda</a></li>
                            <li><a href="#contato">Contato</a></li>
                        </ul>
                    </div>

                    
                    <div className="footer-contato">
                        <h4 className="footer-col-titulo">Contato</h4>
                        <ul className="footer-links">
                            <li>João Pessoa, PB</li>
                            <li>
                                <a href="https://wa.me/5583999999999" target="_blank" rel="noopener noreferrer">
                                    (83) 99999-9999
                                </a>
                            </li>
                            <li>
                                <a href="mailto:contato@docecoracao.org">
                                    contato@docecoracao.org
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                
                <div className="footer-bottom">
                    <p>&copy; 2026 Missão JHS Doce Coração. Todos os direitos reservados.</p>
                    <a href="#" className="footer-lgpd">Política de privacidade</a>
                </div>

            </div>
        </footer>
    </footer>
  );
}