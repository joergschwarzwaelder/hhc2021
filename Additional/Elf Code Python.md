<h1 id="elf-code-python">Elf Code Python</h1>
<p><strong>Location: Dining Room, Santa’s Castle, Ground Floor</strong><br>
<strong>Elf: Ribb Bonbowford</strong></p>
<p>This game is about getting familiar with Python.</p>
<h3 id="level-1">Level 1:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">)</span>
</code></pre>
<h3 id="level-2">Level 2:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveRight<span class="token punctuation">(</span><span class="token number">3</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">3</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">6</span><span class="token punctuation">)</span>
</code></pre>
<h3 id="level-3">Level 3:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
lever0 <span class="token operator">=</span> levers<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span>
lollipop0 <span class="token operator">=</span> lollipops<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever0<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever0<span class="token punctuation">.</span>pull<span class="token punctuation">(</span>lever0<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">+</span><span class="token number">2</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lollipop0<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">)</span>
</code></pre>
<h3 id="level-4">Level 4:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
<span class="token comment"># Complete the code below:</span>
lever0<span class="token punctuation">,</span> lever1<span class="token punctuation">,</span> lever2<span class="token punctuation">,</span> lever3<span class="token punctuation">,</span> lever4 <span class="token operator">=</span> levers<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token comment"># Move onto lever4</span>
elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
<span class="token comment"># This lever wants a str object:</span>
lever4<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token string">"A String"</span><span class="token punctuation">)</span>
<span class="token comment"># Need more code below:</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever3<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever3<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token boolean">True</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever2<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever2<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever1<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever1<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token string">"Kingle"</span><span class="token punctuation">,</span><span class="token string">"Con"</span><span class="token punctuation">]</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever0<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever0<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token punctuation">{</span><span class="token string">"country"</span> <span class="token punctuation">:</span> <span class="token string">"France"</span><span class="token punctuation">,</span> <span class="token string">"worldcups"</span> <span class="token punctuation">:</span> <span class="token number">2</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
</code></pre>
<h2 id="level-5">Level 5:</h2>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
lever0<span class="token punctuation">,</span> lever1<span class="token punctuation">,</span> lever2<span class="token punctuation">,</span> lever3<span class="token punctuation">,</span> lever4 <span class="token operator">=</span> levers<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever4<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever4<span class="token punctuation">.</span>pull<span class="token punctuation">(</span>lever4<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">+</span><span class="token string">" concatenate"</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever3<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever3<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token operator">not</span> lever3<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever2<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever2<span class="token punctuation">.</span>pull<span class="token punctuation">(</span>lever2<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">+</span><span class="token number">1</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever1<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
<span class="token builtin">list</span><span class="token operator">=</span>lever1<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token builtin">list</span><span class="token punctuation">.</span>append<span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span>
lever1<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token builtin">list</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever0<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
<span class="token builtin">dict</span><span class="token operator">=</span>lever0<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token builtin">dict</span><span class="token punctuation">[</span><span class="token string">'strkey'</span><span class="token punctuation">]</span><span class="token operator">=</span><span class="token string">'strvalue'</span>
lever0<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token builtin">dict</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
</code></pre>
<h3 id="level-6">Level 6:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
lever <span class="token operator">=</span> levers<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
data <span class="token operator">=</span> lever<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token keyword">if</span> <span class="token builtin">type</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token builtin">bool</span><span class="token punctuation">:</span>
    data <span class="token operator">=</span> <span class="token operator">not</span> data
<span class="token keyword">elif</span> <span class="token builtin">type</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token builtin">int</span><span class="token punctuation">:</span>
    data <span class="token operator">=</span> data <span class="token operator">*</span> <span class="token number">2</span> 
<span class="token keyword">elif</span> <span class="token builtin">type</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token builtin">str</span><span class="token punctuation">:</span>
    data <span class="token operator">=</span> data<span class="token operator">+</span>data
<span class="token keyword">elif</span> <span class="token builtin">type</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token builtin">list</span><span class="token punctuation">:</span>
    data <span class="token operator">=</span> <span class="token builtin">map</span><span class="token punctuation">(</span><span class="token keyword">lambda</span> number <span class="token punctuation">:</span> number<span class="token operator">+</span><span class="token number">1</span><span class="token punctuation">,</span>data<span class="token punctuation">)</span>
<span class="token keyword">elif</span> <span class="token builtin">type</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token builtin">dict</span><span class="token punctuation">:</span>
    data<span class="token punctuation">[</span><span class="token string">'a'</span><span class="token punctuation">]</span><span class="token operator">=</span>data<span class="token punctuation">[</span><span class="token string">'a'</span><span class="token punctuation">]</span><span class="token operator">+</span><span class="token number">1</span>
lever<span class="token punctuation">.</span>pull<span class="token punctuation">(</span>data<span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
</code></pre>
<h3 id="level-7">Level 7:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
<span class="token keyword">for</span> num <span class="token keyword">in</span> <span class="token builtin">range</span><span class="token punctuation">(</span><span class="token number">3</span><span class="token punctuation">)</span><span class="token punctuation">:</span>
    elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">3</span><span class="token punctuation">)</span>
    elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">11</span><span class="token punctuation">)</span>
    elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
    elf<span class="token punctuation">.</span>moveDown<span class="token punctuation">(</span><span class="token number">11</span><span class="token punctuation">)</span>
</code></pre>
<h3 id="level-8">Level 8:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
all_lollipops <span class="token operator">=</span> lollipops<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token keyword">for</span> lollipop <span class="token keyword">in</span> all_lollipops<span class="token punctuation">:</span>
    elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lollipop<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
lever<span class="token operator">=</span>levers<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lever<span class="token punctuation">.</span>position<span class="token punctuation">)</span>
<span class="token builtin">list</span><span class="token operator">=</span>lever<span class="token punctuation">.</span>data<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token builtin">list</span><span class="token punctuation">.</span>insert<span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">,</span><span class="token string">"munchkins rule"</span><span class="token punctuation">)</span>
lever<span class="token punctuation">.</span>pull<span class="token punctuation">(</span><span class="token builtin">list</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveDown<span class="token punctuation">(</span><span class="token number">3</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">6</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
</code></pre>
<p><strong>Achievement: Elf Code Python</strong></p>
<h3 id="bonus-levels">Bonus Levels</h3>
<h3 id="level-9">Level 9:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits

<span class="token keyword">def</span> <span class="token function">func_to_pass_to_munchkin</span><span class="token punctuation">(</span>list_of_lists<span class="token punctuation">)</span><span class="token punctuation">:</span>
    <span class="token keyword">return</span> <span class="token builtin">sum</span><span class="token punctuation">(</span><span class="token builtin">list</span><span class="token punctuation">(</span><span class="token builtin">map</span><span class="token punctuation">(</span><span class="token keyword">lambda</span> l <span class="token punctuation">:</span> <span class="token builtin">sum</span><span class="token punctuation">(</span><span class="token punctuation">[</span>i <span class="token keyword">for</span> i <span class="token keyword">in</span> l <span class="token keyword">if</span> <span class="token builtin">isinstance</span><span class="token punctuation">(</span>i<span class="token punctuation">,</span><span class="token builtin">int</span><span class="token punctuation">)</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">,</span>list_of_lists<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">)</span>

munchkins<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">.</span>answer<span class="token punctuation">(</span>func_to_pass_to_munchkin<span class="token punctuation">)</span>
all_levers <span class="token operator">=</span> levers<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token punctuation">)</span>
moves <span class="token operator">=</span> <span class="token punctuation">[</span>elf<span class="token punctuation">.</span>moveDown<span class="token punctuation">,</span> elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">,</span> elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">,</span> elf<span class="token punctuation">.</span>moveRight<span class="token punctuation">]</span> <span class="token operator">*</span> <span class="token number">2</span>
<span class="token keyword">for</span> i<span class="token punctuation">,</span> move <span class="token keyword">in</span> <span class="token builtin">enumerate</span><span class="token punctuation">(</span>moves<span class="token punctuation">)</span><span class="token punctuation">:</span>
    move<span class="token punctuation">(</span>i<span class="token operator">+</span><span class="token number">1</span><span class="token punctuation">)</span>
    <span class="token keyword">if</span> i<span class="token operator">&lt;</span><span class="token builtin">len</span><span class="token punctuation">(</span>all_levers<span class="token punctuation">)</span><span class="token punctuation">:</span>
      all_levers<span class="token punctuation">[</span>i<span class="token punctuation">]</span><span class="token punctuation">.</span>pull<span class="token punctuation">(</span>i<span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">4</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span>
</code></pre>
<h3 id="level-10">Level 10:</h3>
<pre class=" language-python"><code class="prism  language-python"><span class="token keyword">import</span> elf<span class="token punctuation">,</span> munchkins<span class="token punctuation">,</span> levers<span class="token punctuation">,</span> lollipops<span class="token punctuation">,</span> yeeters<span class="token punctuation">,</span> pits
<span class="token keyword">import</span> time
 
muns <span class="token operator">=</span> munchkins<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token punctuation">)</span>
lols <span class="token operator">=</span> lollipops<span class="token punctuation">.</span>get<span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">[</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">]</span>
<span class="token keyword">for</span> index<span class="token punctuation">,</span> mun <span class="token keyword">in</span> <span class="token builtin">enumerate</span><span class="token punctuation">(</span>muns<span class="token punctuation">)</span><span class="token punctuation">:</span>
  <span class="token keyword">while</span> <span class="token builtin">abs</span><span class="token punctuation">(</span>mun<span class="token punctuation">.</span>position<span class="token punctuation">[</span><span class="token string">"x"</span><span class="token punctuation">]</span><span class="token operator">-</span>elf<span class="token punctuation">.</span>position<span class="token punctuation">[</span><span class="token string">"x"</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token operator">&lt;</span><span class="token number">6</span><span class="token punctuation">:</span>
    time<span class="token punctuation">.</span>sleep<span class="token punctuation">(</span><span class="token number">0.1</span><span class="token punctuation">)</span>
  elf<span class="token punctuation">.</span>moveTo<span class="token punctuation">(</span>lols<span class="token punctuation">[</span>index<span class="token punctuation">]</span><span class="token punctuation">.</span>position<span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveLeft<span class="token punctuation">(</span><span class="token number">6</span><span class="token punctuation">)</span>
elf<span class="token punctuation">.</span>moveUp<span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">)</span>
</code></pre>
<p><strong>Achievement: Elf Code Python Bonus Levels!</strong></p>
<p>The Elf provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-12">objective 12</a>, which are not captured in Avatar’s hint section:<br>
<strong><a href="https://www.npmjs.com/package/express-session">Node.js express-session</a></strong><br>
<strong><a href="https://github.com/mysqljs/mysql">mysqljs</a></strong></p>

