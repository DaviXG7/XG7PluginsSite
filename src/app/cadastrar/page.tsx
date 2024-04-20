"use client"
import "./css/body.scss"

import Logo from "../imgs/logo.png";


export default function Site() {
    return (
      <>
  
        <form action="/login" method='post'>
          <img src={ Logo.src } alt="Logo" />

            <input type="text" name="nome" placeholder='nome de usuário*'/>

            <input type="text" name="login" placeholder='email*'/>

            <label htmlFor="data">Data de nascimento opicional</label>
            <input type="date" name="data" placeholder='data' />
            
            <input type="text" placeholder='senha*'/>

            <input type="password" placeholder='confirmar senha*'/>
            
            <input type="submit" />

        </form>

      </>
      
    );
  }