<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output   method="text"/>
	<xsl:variable name="cr"><xsl:text>&#xa;</xsl:text></xsl:variable>
	<xsl:variable name="cr4sp" ><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr8sp" ><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr12sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr16sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr20sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:template match="/">

	  <!-- Проверка безопасности -->
		<xsl:value-of select="concat($cr4sp, 'function checkSecurity(req, res, callback){', $cr)"/>
		<xsl:value-of select="concat($cr8sp, 'callback(req, res)')"/>
		<xsl:value-of select="concat($cr4sp, '}', $cr)"/>

	  <!-- Обработка ошибок -->
		<xsl:value-of select="concat($cr4sp, 'function rpcErrors(errId, params, req, res){', $cr)"/>
		<xsl:value-of select="concat($cr8sp, 'sendError(res)')"/>
		<xsl:value-of select="concat($cr8sp, 'console.log(new Date())')"/>
		<xsl:value-of select="concat($cr8sp, 'console.log(errId)')"/>
		<xsl:value-of select="concat($cr8sp, 'console.log(params)')"/>
		<xsl:value-of select="concat($cr8sp, 'console.log(&quot;&quot;)')"/>
		<xsl:value-of select="concat($cr4sp, '}', $cr)"/>

	  <!-- Параметры SQL-запросов -->
    <xsl:value-of select="concat($cr4sp, 'function sendSql(sqlId, params, req, res){')"/>
    <xsl:value-of select="concat($cr8sp, 'var replay = []')"/>
    <xsl:value-of select="concat($cr8sp, 'var query = psql.query(prepareStatement(sqlId, params))')"/>
    <xsl:value-of select="concat($cr12sp, 'query.on(&quot;row&quot;, function(row){')"/>
    <xsl:value-of select="concat($cr12sp, 'replay.push(row)'	)"/>
    <xsl:value-of select="concat($cr8sp, '})')"/>
    <xsl:value-of select="concat($cr8sp, 'query.on(&quot;error&quot;, function (err) {')"/>
    <xsl:value-of select="concat($cr12sp, 'console.log(err)')"/>
    <xsl:value-of select="concat($cr12sp, 'replay.push({err: &quot;Error in function &quot; + sqlId})')"/>
    <xsl:value-of select="concat($cr8sp, '})')"/>
    <xsl:value-of select="concat($cr8sp, 'query.on(&quot;end&quot;, function () {')"/>
    <xsl:value-of select="concat($cr12sp, 'res.setHeader(&quot;Content-Type&quot;, &quot;application/json; charset=utf-8&quot;)')"/>
    <xsl:value-of select="concat($cr12sp, 'if(replay.length == 0) replay.push({result: &quot;empty&quot;})')"/>
    <xsl:value-of select="concat($cr12sp, 'if(debug)console.log(replay)')"/>
    <xsl:value-of select="concat($cr12sp, 'res.send(replay)')"/>
    <xsl:value-of select="concat($cr8sp, '})')"/>
    <xsl:value-of select="concat($cr4sp, '}', $cr)"/>
    <xsl:value-of select="concat($cr4sp, 'function prepareStatement(sqlId, params){', $cr)"/>
    <xsl:value-of select="concat($cr8sp, 'var sqlSet = {')"/>
    <xsl:value-of select="concat($cr12sp, 'values: params,')"/>
    <xsl:value-of select="concat($cr12sp, 'name: sqlId')"/>
    <xsl:value-of select="concat($cr8sp, '}', $cr)"/>
    <xsl:value-of select="concat($cr8sp, 'switch(sqlId){')"/>
	  <xsl:for-each select="*/rpc[@proxy = 'sql']">
        <xsl:value-of select="concat($cr12sp, 'case ', '&quot;', @id, '&quot;:')"/>
        <xsl:value-of select="concat($cr16sp, 'sqlSet.text = &quot;select ', @id, '(')"/>
	      <xsl:for-each select="param">
            <xsl:value-of select="concat('$', position())"/>
				    <xsl:if test="position() != count(../param)">
                    <xsl:text>,&#x20;</xsl:text>
				    </xsl:if>	
            </xsl:for-each>
            <xsl:text>)&quot;</xsl:text>
            <xsl:value-of select="concat($cr16sp, 'return sqlSet', $cr)"/>
        </xsl:for-each>
        <xsl:value-of select="concat($cr8sp, '}')"/>
		<xsl:value-of select="concat($cr4sp, '}', $cr)"/>

	  <!-- Обработка ответов сервера после фильтрации -->
		<xsl:value-of select="concat($cr4sp, 'function rpcFinish(procId, params, req, res){', $cr)"/>
        <xsl:value-of select="concat($cr8sp, 'switch(procId){')"/>
	      <xsl:for-each select="*/rpc[@proxy='sql']">
            <xsl:value-of select="concat($cr12sp, 'case ', '&quot;', @id, '&quot;:')"/>
        </xsl:for-each>
        <xsl:value-of select="concat($cr16sp, 'sendSql(procId, __.values(params), req, res)')"/>
        <xsl:value-of select="concat($cr16sp, 'break', $cr)"/>
	      <xsl:for-each select="*/rpc[not(@proxy)]">
            <xsl:value-of select="concat($cr12sp, 'case ', '&quot;', @id, '&quot;:')"/>
            <xsl:value-of select="concat($cr16sp, @id, '_finish(__.values(params), req, res)')"/>
            <xsl:value-of select="concat($cr16sp, 'break', $cr)"/>
        </xsl:for-each>
        <xsl:value-of select="concat($cr12sp, 'default:')"/>
        <xsl:value-of select="concat($cr16sp, '    res.setHeader(&quot;Content-Type&quot;, &quot;application/json; charset=utf-8&quot;)')"/>
        <xsl:value-of select="concat($cr16sp, '    res.send([{err: procId}])')"/>
        <xsl:value-of select="concat($cr8sp, '}')"/>
		<xsl:value-of select="concat($cr4sp, '}', $cr)"/>

	  <!-- Шаблоны фильтров -->
		<xsl:value-of select="concat($cr4sp, 'var rpcQueries = {', $cr)"/>
	    <xsl:for-each select="*/rpc">
        <xsl:value-of select="concat($cr8sp, '/* ', description/node(), ' */')"/>
        <xsl:value-of select="concat($cr8sp, @id, ': {')"/>
		    <xsl:value-of select="concat($cr12sp, 'query:  &quot;', @id, '&quot;,')"/>
		    <xsl:value-of select="concat($cr12sp, 'params: [')"/>
	      <xsl:for-each select="param">
            <xsl:value-of select="concat($cr16sp, '{')"/>
            <xsl:value-of select="concat($cr20sp, 'name: ', '&quot;', @name, '&quot;,')"/>
            <xsl:value-of select="concat($cr20sp, 'value: null,')"/>
            <xsl:value-of select="concat($cr20sp, 'filter: &quot;', @filter, '&quot;,')"/>
            <xsl:value-of select="concat($cr20sp, 'onFailure: function(){}')"/>
            <xsl:value-of select="concat($cr16sp, '},')"/>
        </xsl:for-each>
		    <xsl:value-of select="concat($cr12sp, '],')"/>
		    <xsl:value-of select="concat($cr12sp, 'onSuccess: ')"/>
        <xsl:value-of select="concat($cr12sp, 'function(req, res){')"/>
        <xsl:value-of select="concat($cr16sp, 'rpcFinish(&quot;', @id, '&quot;, this, req, res)')"/>
        <xsl:value-of select="concat($cr12sp, '},')"/>
		    <xsl:value-of select="concat($cr12sp, 'onError: ')"/>
        <xsl:value-of select="concat($cr12sp, 'function(req, res){')"/>
        <xsl:value-of select="concat($cr16sp, 'rpcErrors(&quot;', @id, '&quot;, this, req, res)')"/>
        <xsl:value-of select="concat($cr12sp, '}')"/>
		    <xsl:value-of select="concat($cr8sp,  '},', $cr)"/>
      </xsl:for-each>
		<xsl:value-of select="concat($cr4sp, '}', $cr)"/>

	  <!-- Proxy -->
	  <xsl:for-each select="*/rpc">
       <xsl:value-of select="concat($cr, $cr4sp, '/* ', description/node(), ' */')"/>
       <xsl:value-of select="concat($cr4sp, 'function ', @id, '(req, res){')"/>
       <xsl:value-of select="concat($cr8sp, 'var query = __.clone(rpcQueries[&quot;', @id, '&quot;])')"/>
		   <xsl:for-each select="param">
		      <xsl:value-of select="concat($cr8sp, '__.bind(setRpcParam, query, ', '&quot;', @name, '&quot;, req.query.', @name, ')()')"/>
          <xsl:if test="@name = 'uid'">
		        <xsl:value-of select="concat($cr8sp, 'if(getCookie(&quot;AsfnUid&quot;, req, res) &amp;&amp; !/^\/adm.+/.test(req.path + &quot;&quot;)){')"/>
		        <xsl:value-of select="concat($cr12sp, '__.bind(setRpcParam, query, ', '&quot;', @name, '&quot;, getCookie(&quot;AsfnUid&quot;, req, res))()')"/>
		        <xsl:value-of select="concat($cr8sp, '}')"/>
          </xsl:if>
		   </xsl:for-each>
       <xsl:value-of select="concat($cr8sp, 'query[&quot;response&quot;] = res')"/>
       <xsl:value-of select="concat($cr8sp, 'query[&quot;request&quot;]  = req')"/>
       <xsl:value-of select="concat($cr8sp, '__(query).check()')"/>
       <xsl:value-of select="concat($cr4sp, '}')"/>
    </xsl:for-each>

	  <!-- Сервлеты -->
	  <xsl:for-each select="*/rpc">
        <xsl:value-of select="concat($cr, $cr4sp, '/* ', description/node(), ' */')"/>
        <xsl:value-of select="concat($cr4sp, 'app.get(&quot;/', @id, '&quot;, function(req, res){')"/>
        <xsl:value-of select="concat($cr8sp,  @id, '(req, res)')"/>
        <xsl:value-of select="concat($cr4sp, '})')"/>
    </xsl:for-each>

	  <!-- Админка -->
	  <xsl:for-each select="*/rpc[substring-before(@id, '_') = 'get']">
        <xsl:value-of select="concat($cr, $cr4sp, '/* ', description/node(), ' */')"/>
        <xsl:value-of select="concat($cr4sp, 'app.get(&quot;/adm_', @id, '&quot;, function(req, res){')"/>
        <xsl:value-of select="concat($cr8sp,  @id, '(req, res)')"/>
        <xsl:value-of select="concat($cr4sp, '})')"/>
    </xsl:for-each>
    <xsl:value-of select="concat($cr, $cr4sp, 'app.listen(8080)')"/>
  </xsl:template>
</xsl:stylesheet>
