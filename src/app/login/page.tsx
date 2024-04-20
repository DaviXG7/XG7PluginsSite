"use client"
import { useState } from 'react';
import "./css/body.scss"

import Logo from "../imgs/logo.png";


export default function Site() {
    return (
      <>
  
        <form action="/login" method='post'>
          <img src={ Logo.src } alt="Logo" />
            <label htmlFor="login">login</label>
            <input type="text" name="login" placeholder='email'/>

            <input type="text" placeholder='senha'/>
            
            <input type="submit" />
            <a href="../cadastrar">Não tem uma conta?</a>

        </form>

      </>
      
    );
  }