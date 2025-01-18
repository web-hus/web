import React, { useState, useEffect } from "react";
import { models } from 'powerbi-client';
import { PowerBIEmbed } from 'powerbi-client-react';

function PowerBIDashboard() {
    return (
        <div>
            <h1>Dashboard Nhà Hàng 3 Miền</h1>
            <iframe
                title="Power BI Dashboard"
                width="100%"
                height="800"
                src="https://app.powerbi.com/reportEmbed?reportId=9605ef62-73b7-462f-a318-ac3a6215e796&autoAuth=true&ctid=7166e234-fcc9-48af-8878-d33812a8b780"
                frameBorder="0"
                allowFullScreen
            />
        </div>
    );
}

export default PowerBIDashboard;
