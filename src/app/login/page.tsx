"use client"
import { useState } from 'react';
import "./body.scss"

import Logo from "../imgs/logo.png";


export default function Site() {
    return (
      <>
  
        <form action="/login" method='post'>
          <img src={ Logo.src } alt="Logo" />
            <label htmlFor="login">
              <p>Login</p>
              
            </label>
            <input type="text" name="login"/>
            <input type="text" />

            <p>
              
            </p>
            
            <input type="submit" />

        </form>

      </>
      
    );
  }