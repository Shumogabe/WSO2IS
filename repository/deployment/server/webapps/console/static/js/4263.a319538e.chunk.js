"use strict";(self.webpackChunk_wso2is_console=self.webpackChunk_wso2is_console||[]).push([[4263],{88752:(e,a,t)=>{t.d(a,{Z:()=>w});var r=t(55467),o=t(25340),i=t(44194),n=t(14517),s=t(87883),l=t(69838),d=t(49058),c=t(62808),h=t(99769),u=t(90757);function m(e){return(0,u.ZP)("MuiFab",e)}const p=(0,h.Z)("MuiFab",["root","primary","secondary","extended","circular","focusVisible","disabled","colorInherit","sizeSmall","sizeMedium","sizeLarge","info","error","warning","success"]);var g=t(49706),v=t(31549);const b=["children","className","color","component","disabled","disableFocusRipple","focusVisibleClassName","size","variant"],f=(0,g.ZP)(l.Z,{name:"MuiFab",slot:"Root",shouldForwardProp:e=>(0,g.FO)(e)||"classes"===e,overridesResolver:(e,a)=>{const{ownerState:t}=e;return[a.root,a[t.variant],a[`size${(0,d.Z)(t.size)}`],"inherit"===t.color&&a.colorInherit,a[(0,d.Z)(t.size)],a[t.color]]}})((({theme:e,ownerState:a})=>{var t,r;return(0,o.Z)({},e.typography.button,{minHeight:36,transition:e.transitions.create(["background-color","box-shadow","border-color"],{duration:e.transitions.duration.short}),borderRadius:"50%",padding:0,minWidth:0,width:56,height:56,zIndex:(e.vars||e).zIndex.fab,boxShadow:(e.vars||e).shadows[6],"&:active":{boxShadow:(e.vars||e).shadows[12]},color:e.vars?e.vars.palette.text.primary:null==(t=(r=e.palette).getContrastText)?void 0:t.call(r,e.palette.grey[300]),backgroundColor:(e.vars||e).palette.grey[300],"&:hover":{backgroundColor:(e.vars||e).palette.grey.A100,"@media (hover: none)":{backgroundColor:(e.vars||e).palette.grey[300]},textDecoration:"none"},[`&.${p.focusVisible}`]:{boxShadow:(e.vars||e).shadows[6]}},"small"===a.size&&{width:40,height:40},"medium"===a.size&&{width:48,height:48},"extended"===a.variant&&{borderRadius:24,padding:"0 16px",width:"auto",minHeight:"auto",minWidth:48,height:48},"extended"===a.variant&&"small"===a.size&&{width:"auto",padding:"0 8px",borderRadius:17,minWidth:34,height:34},"extended"===a.variant&&"medium"===a.size&&{width:"auto",padding:"0 16px",borderRadius:20,minWidth:40,height:40},"inherit"===a.color&&{color:"inherit"})}),(({theme:e,ownerState:a})=>(0,o.Z)({},"inherit"!==a.color&&"default"!==a.color&&null!=(e.vars||e).palette[a.color]&&{color:(e.vars||e).palette[a.color].contrastText,backgroundColor:(e.vars||e).palette[a.color].main,"&:hover":{backgroundColor:(e.vars||e).palette[a.color].dark,"@media (hover: none)":{backgroundColor:(e.vars||e).palette[a.color].main}}})),(({theme:e})=>({[`&.${p.disabled}`]:{color:(e.vars||e).palette.action.disabled,boxShadow:(e.vars||e).shadows[0],backgroundColor:(e.vars||e).palette.action.disabledBackground}}))),w=i.forwardRef((function(e,a){const t=(0,c.Z)({props:e,name:"MuiFab"}),{children:i,className:l,color:h="default",component:u="button",disabled:p=!1,disableFocusRipple:g=!1,focusVisibleClassName:w,size:Z="large",variant:x="circular"}=t,k=(0,r.Z)(t,b),y=(0,o.Z)({},t,{color:h,component:u,disabled:p,disableFocusRipple:g,size:Z,variant:x}),C=(e=>{const{color:a,variant:t,classes:r,size:i}=e,n={root:["root",t,`size${(0,d.Z)(i)}`,"inherit"===a?"colorInherit":a]},l=(0,s.Z)(n,m,r);return(0,o.Z)({},r,l)})(y);return(0,v.jsx)(f,(0,o.Z)({className:(0,n.Z)(C.root,l),component:u,disabled:p,focusRipple:!g,focusVisibleClassName:(0,n.Z)(C.focusVisible,w),ownerState:y,ref:a},k,{classes:C,children:i}))}))},23800:(e,a,t)=>{t.d(a,{Z:()=>N});var r=t(55467),o=t(25340),i=t(44194),n=t(14517),s=t(60391),l=t(87883);function d(e){return String(e).match(/[\d.\-+]*\s*(.*)/)[1]||""}function c(e){return parseFloat(e)}var h=t(24731),u=t(49706),m=t(62808),p=t(99769),g=t(90757);function v(e){return(0,g.ZP)("MuiSkeleton",e)}(0,p.Z)("MuiSkeleton",["root","text","rectangular","rounded","circular","pulse","wave","withChildren","fitContent","heightAuto"]);var b=t(31549);const f=["animation","className","component","height","style","variant","width"];let w,Z,x,k,y=e=>e;const C=(0,s.F4)(w||(w=y`
  0% {
    opacity: 1;
  }

  50% {
    opacity: 0.4;
  }

  100% {
    opacity: 1;
  }
`)),R=(0,s.F4)(Z||(Z=y`
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
`)),S=(0,u.ZP)("span",{name:"MuiSkeleton",slot:"Root",overridesResolver:(e,a)=>{const{ownerState:t}=e;return[a.root,a[t.variant],!1!==t.animation&&a[t.animation],t.hasChildren&&a.withChildren,t.hasChildren&&!t.width&&a.fitContent,t.hasChildren&&!t.height&&a.heightAuto]}})((({theme:e,ownerState:a})=>{const t=d(e.shape.borderRadius)||"px",r=c(e.shape.borderRadius);return(0,o.Z)({display:"block",backgroundColor:e.vars?e.vars.palette.Skeleton.bg:(0,h.Fq)(e.palette.text.primary,"light"===e.palette.mode?.11:.13),height:"1.2em"},"text"===a.variant&&{marginTop:0,marginBottom:0,height:"auto",transformOrigin:"0 55%",transform:"scale(1, 0.60)",borderRadius:`${r}${t}/${Math.round(r/.6*10)/10}${t}`,"&:empty:before":{content:'"\\00a0"'}},"circular"===a.variant&&{borderRadius:"50%"},"rounded"===a.variant&&{borderRadius:(e.vars||e).shape.borderRadius},a.hasChildren&&{"& > *":{visibility:"hidden"}},a.hasChildren&&!a.width&&{maxWidth:"fit-content"},a.hasChildren&&!a.height&&{height:"auto"})}),(({ownerState:e})=>"pulse"===e.animation&&(0,s.iv)(x||(x=y`
      animation: ${0} 1.5s ease-in-out 0.5s infinite;
    `),C)),(({ownerState:e,theme:a})=>"wave"===e.animation&&(0,s.iv)(k||(k=y`
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
    `),R,(a.vars||a).palette.action.hover))),N=i.forwardRef((function(e,a){const t=(0,m.Z)({props:e,name:"MuiSkeleton"}),{animation:i="pulse",className:s,component:d="span",height:c,style:h,variant:u="text",width:p}=t,g=(0,r.Z)(t,f),w=(0,o.Z)({},t,{animation:i,component:d,variant:u,hasChildren:Boolean(g.children)}),Z=(e=>{const{classes:a,variant:t,animation:r,hasChildren:o,width:i,height:n}=e,s={root:["root",t,r,o&&"withChildren",o&&!i&&"fitContent",o&&!n&&"heightAuto"]};return(0,l.Z)(s,v,a)})(w);return(0,b.jsx)(S,(0,o.Z)({as:d,ref:a,className:(0,n.Z)(Z.root,s),ownerState:w},g,{style:(0,o.Z)({width:p,height:c},h)}))}))},88847:(e,a,t)=>{t.d(a,{Z:()=>s});var r=t(92336),o=t(31549),i=t(88752),n=t(14517);const s=(0,t(44194).forwardRef)(((e,a)=>{var{className:t}=e,s=(0,r.__rest)(e,["className"]);return(0,o.jsx)(i.Z,Object.assign({ref:a,className:(0,n.Z)("oxygen-fab","OxygenFab-root",t)},s))}))},92546:(e,a,t)=>{t.d(a,{Z:()=>s});var r=t(92336),o=t(31549),i=t(23269),n=t(14517);const s=(0,t(44194).forwardRef)(((e,a)=>{var{className:t}=e,s=(0,r.__rest)(e,["className"]);return(0,o.jsx)(i.Z,Object.assign({className:(0,n.Z)("oxygen-paper","OxygenPaper-root",t)},s,{ref:a}))}))},41121:(e,a,t)=>{t.d(a,{ZP:()=>s});var r=t(92336),o=t(31549),i=t(17751),n=t(14517);const s=(0,t(44194).forwardRef)(((e,a)=>{var{className:t}=e,s=(0,r.__rest)(e,["className"]);return(0,o.jsx)(i.ZP,Object.assign({className:(0,n.Z)("oxygen-popover","OxygenPopover-root",t)},s,{ref:a}))}))},72711:(e,a,t)=>{t.d(a,{Z:()=>s});var r=t(92336),o=t(31549),i=t(23800),n=t(14517);const s=(0,t(44194).forwardRef)(((e,a)=>{var{className:t}=e,s=(0,r.__rest)(e,["className"]);return(0,o.jsx)(i.Z,Object.assign({ref:a,className:(0,n.Z)("oxygen-skeleton","OxygenSkeleton-root",t)},s))}))}}]);