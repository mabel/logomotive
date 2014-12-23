<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output   method="text"/>
	<xsl:variable name="cr"><xsl:text>&#xa;</xsl:text></xsl:variable>
	<xsl:variable name="cr2sp" ><xsl:text>&#xa;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr4sp" ><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr6sp" ><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr8sp" ><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr10sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr12sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr14sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr16sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr18sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>
	<xsl:variable name="cr20sp"><xsl:text>&#xa;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;&#x20;</xsl:text></xsl:variable>

	<xsl:template match="/">
    <xsl:value-of select="concat('/***************************************************************', $cr)"/>
    <xsl:value-of select="concat('***                Edit these functions manually             ***', $cr)"/>
    <xsl:value-of select="concat('***             according with your business logic.          ***', $cr)"/>
    <xsl:value-of select="concat('***                                                          ***', $cr)"/>
    <xsl:value-of select="concat('****************************************************************/', $cr, $cr)"/>
    <xsl:value-of select="concat('function rpcProcessing(label, data){', $cr)"/>
    <xsl:value-of select="concat($cr2sp, 'switch(label){', $cr)"/>
	  <xsl:for-each select="*/rpc">
      <xsl:value-of select="concat($cr4sp, '/* ', description/node(), ' */', $cr)"/>
      <xsl:value-of select="concat($cr4sp, 'case &quot;', @id, '&quot;:', $cr4sp, $cr4sp, 'break', $cr)"/>
			<xsl:for-each select="client/param">
        <xsl:value-of select="concat($cr4sp, 'case &quot;', ../../@id, '_', @name, '&quot;:', $cr4sp, $cr4sp, 'break', $cr)"/>
			</xsl:for-each>
    </xsl:for-each>
    <xsl:value-of select="concat($cr2sp, '}', $cr)"/>
    <xsl:value-of select="concat('}', $cr, $cr)"/>
    <xsl:value-of select="concat('/***************************************************************', $cr)"/>
    <xsl:value-of select="concat('***           Code beneath is generated automatically.       ***', $cr)"/>
    <xsl:value-of select="concat('***                  Please don not edit this.               ***', $cr)"/>
    <xsl:value-of select="concat('***                                                          ***', $cr)"/>
    <xsl:value-of select="concat('***************************************************************/', $cr, $cr)"/>
    <xsl:value-of select="concat('var rpcQueries = {}', $cr, $cr)"/>
	  <xsl:for-each select="*/rpc">
      <xsl:value-of select="concat($cr, $cr, 'rpcQueries.', @id, ' = {')"/>
		  <xsl:value-of select="concat($cr2sp, 'descr: &quot;', description/node(), '&quot;,')"/>
		  <xsl:value-of select="concat($cr2sp, 'params: [')"/>
	    <xsl:for-each select="client/param">
        <xsl:value-of select="concat($cr4sp, '{')"/>
        <xsl:value-of select="concat($cr6sp, 'name: ', '&quot;', ../../@id, '_', @name, '&quot;,')"/>
        <xsl:value-of select="concat($cr6sp, 'value: null,')"/>
        <xsl:value-of select="concat($cr6sp, 'filter: &quot;', @filter, '&quot;,')"/>
        <xsl:value-of select="concat($cr6sp, 'onFailure: function(){rpcProcessing(&quot;', ../../@id, '_', @name, '&quot;)}')"/>
        <xsl:value-of select="concat($cr4sp, '},')"/>
      </xsl:for-each>
		  <xsl:value-of select="concat($cr2sp, '],')"/>

		  <xsl:value-of select="concat($cr2sp, 'onSuccess: ')"/>
      <xsl:value-of select="concat($cr4sp, 'function(){')"/>
      <xsl:value-of select="concat($cr6sp, '$.getJSON(&quot;/cgi-bin/rpc.sh&quot;, this, function(data){')"/>
      <xsl:value-of select="concat($cr8sp,  'rpcProcessing(&quot;', @id, '&quot;, data)')"/>
      <xsl:value-of select="concat($cr6sp, '})')"/>
      <xsl:value-of select="concat($cr4sp, '}')"/>

      <xsl:value-of select="concat($cr, '}')"/>
    </xsl:for-each>
		<xsl:value-of select="concat($cr, $cr, '$(function(){')"/>
	  <xsl:for-each select="*/rpc">
      <xsl:value-of select="concat($cr2sp, '$(&quot;#', @id, '_submit&quot;).click(function(){')"/>
      <xsl:value-of select="concat($cr4sp, '/* ', description/node(), ' */')"/>
      <xsl:value-of select="concat($cr4sp, 'var query = __.clone(rpcQueries[&quot;', @id, '&quot;])')"/>
      <xsl:value-of select="concat($cr4sp, 'query.proc_id = &quot;', @id, '&quot;')"/>
      <xsl:value-of select="concat($cr4sp, '__.bind(setRpcParams, query, [')"/>
			<xsl:for-each select="client/param">
        <xsl:value-of select="concat($cr6sp, '$(&quot;#', ../../@id, '_', @name, '&quot;).val(),')"/>
			</xsl:for-each>
      <xsl:value-of select="concat($cr4sp, '])()')"/>
      <xsl:value-of select="concat($cr4sp, '__(query).check()')"/>
      <xsl:value-of select="concat($cr2sp, '})', $cr)"/>
    </xsl:for-each>
    <xsl:value-of select="concat($cr, '})')"/>
  </xsl:template>
</xsl:stylesheet>
