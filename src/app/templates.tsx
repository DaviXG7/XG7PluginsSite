"use client";
import { useState } from "react";

import Logo from "./imgs/logo.png";
import IconPesquisa from "./imgs/procurar.png";
import IconPlug from "./imgs/plug.png";
import IconDiscord from "./imgs/discord.png";
import IconLivro from "./imgs/livro.png";
import IconPessoa from "./imgs/pessoa.png";
import IconHamburger from "./imgs/hamburger.png";

export function MainHeader() {
  const [opened, setOpened] = useState(false);

  const toggle = () => {
    setOpened(!opened);
  };

  return (
    <>
      <nav className="navbar navbar-expand-md navbar-light bg-light border-bottom border-dark rounded-bottom fixed-top">
        <div className="container-fluid">
          <a className="navbar-brand" href="">
            <img src={Logo.src} alt="logo" width={"70px"} />
          </a>
          <button
            className="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#mynavbar"
            aria-controls="mynavbar"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="mynavbar">
            <form className="d-flex bg-light rounded">
              <a href="" className="btn">
                <img src={IconPesquisa.src} alt="" width={"20px"} />
              </a>
              <input
                className="form-control me-2"
                type="text"
                placeholder="Procurar plugin"
              />
            </form>
            <ul className="navbar-nav">
              <li className="nav-item">
                <a className="nav-link" href="">
                  Discord
                </a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="">
                  Plugins
                </a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="">
                  Documentação
                </a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="">
                  Sobre
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </>
  );
}

export function MainFooter() {
  return (
    <>
      <footer
        className="navbar navbar-expand-md"
        style={{ backgroundColor: "rgb(240,240,240)", bottom: "0" }}
      >
        <div className="row justify-content-md-center">
          <div className="col-5">
            <p>Este site não tem nenhuma ligação com MojangAB</p>
          </div>
          <div className="col">
            <a href="">API para desenvolvedores</a>
            <a href="">Termos de serviço</a>
            <a href="">Discord</a>
            <a href="">Cadastrar</a>
          </div>
        </div>
      </footer>
    </>
  );
}
