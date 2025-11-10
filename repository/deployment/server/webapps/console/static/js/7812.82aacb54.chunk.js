"use strict";(self.webpackChunk_wso2is_console=self.webpackChunk_wso2is_console||[]).push([[7812],{23800:(e,t,n)=>{n.d(t,{Z:()=>O});var a=n(55467),r=n(25340),i=n(44194),s=n(14517),o=n(60391),l=n(87883);function h(e){return String(e).match(/[\d.\-+]*\s*(.*)/)[1]||""}function d(e){return parseFloat(e)}var c=n(24731),u=n(49706),m=n(62808),p=n(99769),g=n(90757);function f(e){return(0,g.ZP)("MuiSkeleton",e)}(0,p.Z)("MuiSkeleton",["root","text","rectangular","rounded","circular","pulse","wave","withChildren","fitContent","heightAuto"]);var w=n(31549);const b=["animation","className","component","height","style","variant","width"];let v,y,x,Z,C=e=>e;const N=(0,o.F4)(v||(v=C`
  0% {
    opacity: 1;
  }

  50% {
    opacity: 0.4;
  }

  100% {
    opacity: 1;
  }
`)),S=(0,o.F4)(y||(y=C`
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
`)),k=(0,u.ZP)("span",{name:"MuiSkeleton",slot:"Root",overridesResolver:(e,t)=>{const{ownerState:n}=e;return[t.root,t[n.variant],!1!==n.animation&&t[n.animation],n.hasChildren&&t.withChildren,n.hasChildren&&!n.width&&t.fitContent,n.hasChildren&&!n.height&&t.heightAuto]}})((({theme:e,ownerState:t})=>{const n=h(e.shape.borderRadius)||"px",a=d(e.shape.borderRadius);return(0,r.Z)({display:"block",backgroundColor:e.vars?e.vars.palette.Skeleton.bg:(0,c.Fq)(e.palette.text.primary,"light"===e.palette.mode?.11:.13),height:"1.2em"},"text"===t.variant&&{marginTop:0,marginBottom:0,height:"auto",transformOrigin:"0 55%",transform:"scale(1, 0.60)",borderRadius:`${a}${n}/${Math.round(a/.6*10)/10}${n}`,"&:empty:before":{content:'"\\00a0"'}},"circular"===t.variant&&{borderRadius:"50%"},"rounded"===t.variant&&{borderRadius:(e.vars||e).shape.borderRadius},t.hasChildren&&{"& > *":{visibility:"hidden"}},t.hasChildren&&!t.width&&{maxWidth:"fit-content"},t.hasChildren&&!t.height&&{height:"auto"})}),(({ownerState:e})=>"pulse"===e.animation&&(0,o.iv)(x||(x=C`
      animation: ${0} 1.5s ease-in-out 0.5s infinite;
    `),N)),(({ownerState:e,theme:t})=>"wave"===e.animation&&(0,o.iv)(Z||(Z=C`
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
    `),S,(t.vars||t).palette.action.hover))),O=i.forwardRef((function(e,t){const n=(0,m.Z)({props:e,name:"MuiSkeleton"}),{animation:i="pulse",className:o,component:h="span",height:d,style:c,variant:u="text",width:p}=n,g=(0,a.Z)(n,b),v=(0,r.Z)({},n,{animation:i,component:h,variant:u,hasChildren:Boolean(g.children)}),y=(e=>{const{classes:t,variant:n,animation:a,hasChildren:r,width:i,height:s}=e,o={root:["root",n,a,r&&"withChildren",r&&!i&&"fitContent",r&&!s&&"heightAuto"]};return(0,l.Z)(o,f,t)})(v);return(0,w.jsx)(k,(0,r.Z)({as:h,ref:t,className:(0,s.Z)(y.root,o),ownerState:v},g,{style:(0,r.Z)({width:p,height:d},c)}))}))},15551:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),i=n(5315),s=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(i.Z,Object.assign({ref:t,className:(0,s.Z)("oxygen-alert-title","OxygenAlertTitle-root",n)},o))}))},72711:(e,t,n)=>{n.d(t,{Z:()=>o});var a=n(92336),r=n(31549),i=n(23800),s=n(14517);const o=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsx)(i.Z,Object.assign({ref:t,className:(0,s.Z)("oxygen-skeleton","OxygenSkeleton-root",n)},o))}))},91469:(e,t,n)=>{n.d(t,{Z:()=>l});var a=n(92336),r=n(31549),i=n(14517),s=n(44194),o=n(98855);const l=(0,s.forwardRef)(((e,t)=>{var{className:n,children:s,value:l,index:h}=e,d=(0,a.__rest)(e,["className","children","value","index"]);return(0,r.jsx)(o.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-tab-panel","OxygenTabPanel-root",n),role:"tabpanel",hidden:l!==h},d,{children:l===h&&(0,r.jsx)(o.Z,{children:s})}))}));var h,d,c;h='/**\n * Copyright (c) 2023, WSO2 LLC. (https://www.wso2.com).\n *\n * WSO2 LLC. licenses this file to you under the Apache License,\n * Version 2.0 (the "License"); you may not use this file except\n * in compliance with the License.\n * You may obtain a copy of the License at\n *\n *     http://www.apache.org/licenses/LICENSE-2.0\n *\n * Unless required by applicable law or agreed to in writing,\n * software distributed under the License is distributed on an\n * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY\n * KIND, either express or implied. See the License for the\n * specific language governing permissions and limitations\n * under the License.\n */\n.oxygen-tab-panel {\n  padding: 1rem;\n}',d=document.getElementsByTagName("head")[0],(c=document.createElement("style")).setAttribute("type","text/css"),c.appendChild(document.createTextNode(h)),d.appendChild(c)},65471:(e,t,n)=>{n.d(t,{Z:()=>d});var a=n(92336),r=n(31549),i=n(32507),s=n(14517),o=n(44194),l=n(98855),h=n(82861);const d=(0,o.forwardRef)(((e,t)=>{var{className:n}=e,o=(0,a.__rest)(e,["className"]);return(0,r.jsxs)(l.Z,Object.assign({className:(0,s.Z)("oxygen-tabs","OxygenTabs-root",n)},{children:[(0,r.jsx)(i.Z,Object.assign({ref:t},o)),(0,r.jsx)(h.Z,{})]}))}))},37065:(e,t,n)=>{n.d(t,{Z:()=>r});var a=n(30601);const r=function(e){return(0,a.Z)(e).toLowerCase()}}}]);