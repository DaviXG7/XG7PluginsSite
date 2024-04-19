"use client"
import { useState } from 'react';
import "./header.scss";
import "./footer.scss"

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
    setOpened(!opened)
  }

    return (
      <>
        <header>
            

          <a className='logo' href="">
            <img src={ Logo.src } alt="Logo" />
          </a>
          <div className='pesquisa'>
            <img src={ IconPesquisa.src } alt="icon pesquisa" />
            <input className="pesquisa" type="text" placeholder='Procurar um plugin...' />
          </div>

          <div className='links'>
            <a href="">
              <img src={ IconLivro.src } alt="Docs" width={30} height={30}  />
              <p>Docs</p>
            </a>
            <a href="">
              <img src={ IconPlug.src } alt="Plugins" width={30} height={30}  />
              <p>Plugins</p>
            </a>
            <a href="https://discord.gg/5AjeT3WqJ8" target='_blank'>
              <img src={ IconDiscord.src } alt="Discord" width={30} height={30}  />
              <p>Discord</p>
            </a>
          </div>

          <a className='areaCliente' href="./login">
            <img src={ IconPessoa.src } alt="Cliente" width={30} height={30} />
            <p>Área do Cliente</p>
          </a>

          <button className='btnMenu' onClick={toggle}>
            <img src={ IconHamburger.src } alt="" />
          </button>
        
        </header>

        {opened && (
            <menu>
              <a href="">
                <img src={IconLivro.src} alt="Docs" width={30} height={30} />
                <p>Docs</p>
              </a>
              <a href="">
                <img src={IconPlug.src} alt="Plugins" width={30} height={30} />
                <p>Plugins</p>
              </a>
              <a href="">
                <img src={IconDiscord.src} alt="Discord" width={30} height={30} />
                <p>Discord</p>
              </a>
            </menu>
          )}

      </>
    )
}

export function MainFooter() {

  return <>

    <footer>

      <div className='fesquerda'>
        <p>Este site não tem nenhuma ligação com MojangAB</p>
      </div>
      <div className='fdireita'>
        <a href="">API para desenvolvedores</a>
        <a href="">Termos de serviço</a>
        <a href="">Discord</a>
        <a href="">Cadastrar</a>
      </div>

    </footer>
  
  </>

}