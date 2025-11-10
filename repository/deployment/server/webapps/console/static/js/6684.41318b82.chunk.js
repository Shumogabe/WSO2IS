"use strict";(self.webpackChunk_wso2is_console=self.webpackChunk_wso2is_console||[]).push([[6684],{23800:(e,t,n)=>{n.d(t,{Z:()=>k});var a=n(55467),r=n(25340),s=n(44194),i=n(14517),o=n(60391),l=n(87883);function c(e){return String(e).match(/[\d.\-+]*\s*(.*)/)[1]||""}function d(e){return parseFloat(e)}var h=n(24731),u=n(49706),m=n(62808),g=n(99769),p=n(90757);function f(e){return(0,p.ZP)("MuiSkeleton",e)}(0,g.Z)("MuiSkeleton",["root","text","rectangular","rounded","circular","pulse","wave","withChildren","fitContent","heightAuto"]);var w=n(31549);const v=["animation","className","component","height","style","variant","width"];let b,y,x,Z,N=e=>e;const C=(0,o.F4)(b||(b=N`
  0% {
    opacity: 1;
  }

  50% {
    opacity: 0.4;
  }

  100% {
    opacity: 1;
  }
`)),S=(0,o.F4)(y||(y=N`
  0% {
    transform: translateX(-100%);
  }

  50% {
    /* +0.5s of delay between each loop */
    transform: translateX(100%);
  }

  100% {
    transform: translateX(100%);
  }
`)),O=(0,u.ZP)("span",{name:"MuiSkeleton",slot:"Root",overridesResolver:(e,t)=>{const{ownerState:n}=e;return[t.root,t[n.variant],!1!==n.animation&&t[n.animation],n.hasChildren&&t.withChildren,n.hasChildren&&!n.width&&t.fitContent,n.hasChildren&&!n.height&&t.heightAuto]}})((({theme:e,ownerState:t})=>{const n=c(e.shape.borderRadius)||"px",a=d(e.shape.borderRadius);return(0,r.Z)({display:"block",backgroundColor:e.vars?e.vars.palette.Skeleton.bg:(0,h.Fq)(e.palette.text.primary,"light"===e.palette.mode?.11:.13),height:"1.2em"},"text"===t.variant&&{marginTop:0,marginBottom:0,height:"auto",transformOrigin:"0 55%",transform:"scale(1, 0.60)",borderRadius:`${a}${n}/${Math.round(a/.6*10)/10}${n}`,"&:empty:before":{content:'"\\00a0"'}},"circular"===t.variant&&{borderRadius:"50%"},"rounded"===t.variant&&{borderRadius:(e.vars||e).shape.borderRadius},t.hasChildren&&{"& > *":{visibility:"hidden"}},t.hasChildren&&!t.width&&{maxWidth:"fit-content"},t.hasChildren&&!t.height&&{height:"auto"})}),(({ownerState:e})=>"pulse"===e.animation&&(0,o.iv)(x||(x=N`
      animation: ${0} 1.5s ease-in-out 0.5s infinite;
    `),C)),(({ownerState:e,theme:t})=>"wave"===e.animation&&(0,o.iv)(Z||(Z=N`
      position: relative;
      overflow: hidden;

      /* Fix bug in Safari https://bugs.webkit.org/show_bug.cgi?id=68196 */
      -webkit-mask-image: -webkit-radial-gradient(white, black);

      &::after {
        animation: ${0} 1.6s linear 0.5s infinite;
        background: linear-gradient(
          90deg,
          transparent,
          ${0},
          transparent
        );
        content: '';
        position: absolute;
        transform: translateX(-100%); /* Avoid flash during server-side hydration */
        bottom: 0;
        left: 0;
        right: 0;
        top: 0;
      }
    `),S,(t.vars||t).palette.action.hover))),k=s.forwardRef((function(e,t){const n=(0,m.Z)({props:e,name:"MuiSkeleton"}),{animation:s="pulse",className:o,component:c="span",height:d,style:h,variant:u="text",width:g}=n,p=(0,a.Z)(n,v),b=(0,r.Z)({},n,{animation:s,component:c,variant:u,hasChildren:Boolean(p.children)}),y=(e=>{const{classes:t,variant:n,animation:a,hasChildren:r,width:s,height:i}=e,o={root:["root",n,a,r&&"withChildren",r&&!s&&"fitContent",r&&!i&&"heightAuto"]};return(0,l.Z)(o,f,t)})(b);return(0,w.jsx)(O,(0,r.Z)({as:c,ref:t,className:(0,i.Z)(y.root,o),ownerState:b},p,{style:(0,r.Z)({width:g,height:d},h)}))}))},78367:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),s=n(133),i=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(s.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-alert","OxygenAlert-root",n)},o))}))},51177:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),s=n(5315),i=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(s.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-alert-title","OxygenAlertTitle-root",n)},o))}))},17199:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),s=n(31958),i=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(s.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-box","OxygenBox-root",n)},o))}))},73125:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),s=n(78370),i=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(s.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-button","OxygenButton-root",n)},o))}));var l,c,d;l='/**\n * Copyright (c) 2023, WSO2 LLC. (https://www.wso2.com).\n *\n * WSO2 LLC. licenses this file to you under the Apache License,\n * Version 2.0 (the "License"); you may not use this file except\n * in compliance with the License.\n * You may obtain a copy of the License at\n *\n *     http://www.apache.org/licenses/LICENSE-2.0\n *\n * Unless required by applicable law or agreed to in writing,\n * software distributed under the License is distributed on an\n * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY\n * KIND, either express or implied. See the License for the\n * specific language governing permissions and limitations\n * under the License.\n */\n.oxygen-button.MuiButton-containedPrimary.Mui-disabled {\n  cursor: default;\n  opacity: 0.45;\n  box-shadow: none;\n  pointer-events: none;\n}',c=document.getElementsByTagName("head")[0],(d=document.createElement("style")).setAttribute("type","text/css"),d.appendChild(document.createTextNode(l)),c.appendChild(d)},84394:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),s=n(65740),i=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(s.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-divider","OxygenDivider-root",n)},o))}))},23351:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),s=n(63537),i=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n,position:o}=e,l=(0,a.__rest)(e,["className","position"]);return(0,r.jsx)(s.Z,Object.assign({ref:t,position:o,className:(0,i.Z)("oxygen-input-adornment","OxygenInputAdornment-root",n)},l))}))},78079:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),s=n(23800),i=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(s.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-skeleton","OxygenSkeleton-root",n)},o))}))}}]);