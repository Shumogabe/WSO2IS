"use strict";(self.webpackChunk_wso2is_console=self.webpackChunk_wso2is_console||[]).push([[1506],{23800:(e,t,n)=>{n.d(t,{Z:()=>Z});var r=n(55467),o=n(25340),a=n(44194),i=n(14517),s=n(60391),l=n(87883);function c(e){return String(e).match(/[\d.\-+]*\s*(.*)/)[1]||""}function d(e){return parseFloat(e)}var u=n(24731),h=n(49706),p=n(62808),m=n(99769),f=n(90757);function g(e){return(0,f.ZP)("MuiSkeleton",e)}(0,m.Z)("MuiSkeleton",["root","text","rectangular","rounded","circular","pulse","wave","withChildren","fitContent","heightAuto"]);var b=n(31549);const y=["animation","className","component","height","style","variant","width"];let v,w,S,C,x=e=>e;const R=(0,s.F4)(v||(v=x`
  0% {
    opacity: 1;
  }

  50% {
    opacity: 0.4;
  }

  100% {
    opacity: 1;
  }
`)),O=(0,s.F4)(w||(w=x`
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
`)),N=(0,h.ZP)("span",{name:"MuiSkeleton",slot:"Root",overridesResolver:(e,t)=>{const{ownerState:n}=e;return[t.root,t[n.variant],!1!==n.animation&&t[n.animation],n.hasChildren&&t.withChildren,n.hasChildren&&!n.width&&t.fitContent,n.hasChildren&&!n.height&&t.heightAuto]}})((({theme:e,ownerState:t})=>{const n=c(e.shape.borderRadius)||"px",r=d(e.shape.borderRadius);return(0,o.Z)({display:"block",backgroundColor:e.vars?e.vars.palette.Skeleton.bg:(0,u.Fq)(e.palette.text.primary,"light"===e.palette.mode?.11:.13),height:"1.2em"},"text"===t.variant&&{marginTop:0,marginBottom:0,height:"auto",transformOrigin:"0 55%",transform:"scale(1, 0.60)",borderRadius:`${r}${n}/${Math.round(r/.6*10)/10}${n}`,"&:empty:before":{content:'"\\00a0"'}},"circular"===t.variant&&{borderRadius:"50%"},"rounded"===t.variant&&{borderRadius:(e.vars||e).shape.borderRadius},t.hasChildren&&{"& > *":{visibility:"hidden"}},t.hasChildren&&!t.width&&{maxWidth:"fit-content"},t.hasChildren&&!t.height&&{height:"auto"})}),(({ownerState:e})=>"pulse"===e.animation&&(0,s.iv)(S||(S=x`
      animation: ${0} 1.5s ease-in-out 0.5s infinite;
    `),R)),(({ownerState:e,theme:t})=>"wave"===e.animation&&(0,s.iv)(C||(C=x`
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
    `),O,(t.vars||t).palette.action.hover))),Z=a.forwardRef((function(e,t){const n=(0,p.Z)({props:e,name:"MuiSkeleton"}),{animation:a="pulse",className:s,component:c="span",height:d,style:u,variant:h="text",width:m}=n,f=(0,r.Z)(n,y),v=(0,o.Z)({},n,{animation:a,component:c,variant:h,hasChildren:Boolean(f.children)}),w=(e=>{const{classes:t,variant:n,animation:r,hasChildren:o,width:a,height:i}=e,s={root:["root",n,r,o&&"withChildren",o&&!a&&"fitContent",o&&!i&&"heightAuto"]};return(0,l.Z)(s,g,t)})(v);return(0,b.jsx)(N,(0,o.Z)({as:c,ref:t,className:(0,i.Z)(w.root,s),ownerState:v},f,{style:(0,o.Z)({width:m,height:d},u)}))}))},93331:(e,t,n)=>{function r(e){return r="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol&&e!==Symbol.prototype?"symbol":typeof e},r(e)}function o(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(e,i(r.key),r)}}function a(e,t,n){return t&&o(e.prototype,t),n&&o(e,n),Object.defineProperty(e,"prototype",{writable:!1}),e}function i(e){var t=function(e,t){if("object"!=r(e)||!e)return e;var n=e[Symbol.toPrimitive];if(void 0!==n){var o=n.call(e,t||"default");if("object"!=r(o))return o;throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===t?String:Number)(e)}(e,"string");return"symbol"==r(t)?t:t+""}n.d(t,{Ax:()=>h,eh:()=>d,sf:()=>u});var s,l,c,d=a((function e(){!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,e)}));s=d,c="type",(l=i(l="REMOTE_USER_STORE_TYPE_QUERY_PARAM"))in s?Object.defineProperty(s,l,{value:c,enumerable:!0,configurable:!0,writable:!0}):s[l]=c;var u=function(e){return e.OPTIMIZED="optimized",e.CLASSIC="classic",e}({}),h=function(e){return e.GENERAL="general",e.CONFIGURATIONS="configurations",e.GUIDE="guide",e}({})},29051:(e,t,n)=>{n.d(t,{D:()=>i});var r=n(38463),o=n(86105),a=n(12754),i=function(e,t){var n=(0,o.cr)(e,a.x$.FEATURE_DICTIONARY.get(a.FC.ClassicUserStoreReadGroups)),i=(0,o.cr)(e,a.x$.FEATURE_DICTIONARY.get(a.FC.OptimizedUserStoreReadGroups));return t===r.uD.WSOutboundUserStoreManager&&n||t===r.uD.RemoteUserStoreManager&&i}},56758:(e,t,n)=>{n.d(t,{u:()=>r});var r=function(e,t){var n=new RegExp(t),r=!1,o="";n.test(e)&&(r=!0,null!=n.exec(e)&&(o=n.exec(e).toString()));var a=new Map;return a.set("isMatch",r),a.set("invalidStringValue",o),a}},65002:(e,t,n)=>{n.d(t,{Z:()=>l});var r=n(92336),o=n(31549),a=n(14517),i=n(44194),s=n(10187);const l=(0,i.forwardRef)(((e,t)=>{var{className:n,children:i,filled:l=!0,outlined:c=!1}=e,d=(0,r.__rest)(e,["className","children","filled","outlined"]);return(0,o.jsx)(s.Z,Object.assign({ref:t,component:"code",className:(0,a.Z)("oxygen-code",{filled:l,outlined:c},"OxygenCode-root",{"OxygenCode-filled":l,"OxygenCode-outlined":c},n)},d,{children:i}))}));var c,d,u;c='/**\n * Copyright (c) 2023, WSO2 LLC. (https://www.wso2.com).\n *\n * WSO2 LLC. licenses this file to you under the Apache License,\n * Version 2.0 (the "License"); you may not use this file except\n * in compliance with the License.\n * You may obtain a copy of the License at\n *\n *     http://www.apache.org/licenses/LICENSE-2.0\n *\n * Unless required by applicable law or agreed to in writing,\n * software distributed under the License is distributed on an\n * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY\n * KIND, either express or implied. See the License for the\n * specific language governing permissions and limitations\n * under the License.\n */\n.oxygen-code {\n  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;\n  font-size: inherit;\n  padding: 1px 3px;\n  border-radius: 5px;\n}\n.oxygen-code.filled {\n  background-color: var(--oxygen-palette-customComponents-Code-background);\n}\n.oxygen-code.outlined {\n  border: 1px solid var(--oxygen-palette-divider);\n}',d=document.getElementsByTagName("head")[0],(u=document.createElement("style")).setAttribute("type","text/css"),u.appendChild(document.createTextNode(c)),d.appendChild(u)},4372:(e,t,n)=>{n.d(t,{Z:()=>r.Z});var r=n(65002)},40456:(e,t,n)=>{n.d(t,{Z:()=>s});var r=n(92336),o=n(31549),a=n(5590),i=n(14517);const s=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,s=(0,r.__rest)(e,["className"]);return(0,o.jsx)(a.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-form-label","OxygenFormLabel-root",n)},s))}))},72711:(e,t,n)=>{n.d(t,{Z:()=>s});var r=n(92336),o=n(31549),a=n(23800),i=n(14517);const s=(0,n(44194).forwardRef)(((e,t)=>{var{className:n}=e,s=(0,r.__rest)(e,["className"]);return(0,o.jsx)(a.Z,Object.assign({ref:t,className:(0,i.Z)("oxygen-skeleton","OxygenSkeleton-root",n)},s))}))}}]);