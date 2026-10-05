#!/usr/bin/env python3
import os
import re
from reportlab.lib.pagesizes import letter
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, HRFlowable, PageBreak, KeepTogether
)
from reportlab.lib import colors

def markdown_to_pdf(input_md_path, output_pdf_path, title="Document"):
    with open(input_md_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    doc = SimpleDocTemplate(
        output_pdf_path,
        pagesize=letter,
        leftMargin=40,
        rightMargin=40,
        topMargin=40,
        bottomMargin=40
    )

    styles = getSampleStyleSheet()
    
    # Custom Brand Styles
    primary_color = colors.HexColor("#5B259F")
    secondary_color = colors.HexColor("#401375")
    dark_neutral = colors.HexColor("#1E293B")
    muted_neutral = colors.HexColor("#64748B")
    table_border = colors.HexColor("#E2E8F0")
    table_alt_bg = colors.HexColor("#F8F9FA")

    title_style = ParagraphStyle(
        'DocTitle',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=22,
        leading=26,
        textColor=primary_color,
        spaceAfter=12
    )
    
    h1_style = ParagraphStyle(
        'DocH1',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=15,
        leading=19,
        textColor=secondary_color,
        spaceBefore=14,
        spaceAfter=6
    )

    h2_style = ParagraphStyle(
        'DocH2',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=12,
        leading=16,
        textColor=primary_color,
        spaceBefore=10,
        spaceAfter=4
    )

    body_style = ParagraphStyle(
        'DocBody',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=9.5,
        leading=13.5,
        textColor=dark_neutral,
        spaceAfter=5
    )

    bullet_style = ParagraphStyle(
        'DocBullet',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=9,
        leading=13,
        textColor=dark_neutral,
        leftIndent=15,
        firstLineIndent=-10,
        spaceAfter=3
    )

    table_header_style = ParagraphStyle(
        'TableHeader',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=8.5,
        leading=11,
        textColor=colors.white
    )

    table_cell_style = ParagraphStyle(
        'TableCell',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=8,
        leading=10.5,
        textColor=dark_neutral
    )

    story = []
    
    i = 0
    in_table = False
    table_rows = []

    def clean_text(t):
        t = t.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
        t = re.sub(r'\*\*(.*?)\*\*', r'<b>\1</b>', t)
        t = re.sub(r'\*(.*?)\*', r'<i>\1</i>', t)
        t = re.sub(r'`(.*?)`', r'<font face="Courier" color="#5B259F"><b>\1</b></font>', t)
        return t

    while i < len(lines):
        line = lines[i].rstrip()
        
        # Check for Markdown table
        if line.startswith('|') and '|' in line[1:]:
            # Check if separator row
            if re.match(r'^\|[\s\-:|]+\|$', line):
                i += 1
                continue
            cells = [c.strip() for c in line.strip('|').split('|')]
            table_rows.append(cells)
            in_table = True
            i += 1
            continue
        elif in_table:
            # End of table
            if table_rows:
                num_cols = max(len(r) for r in table_rows)
                # Normalize rows
                formatted_data = []
                for row_idx, r in enumerate(table_rows):
                    row_cells = []
                    for c_idx in range(num_cols):
                        val = r[c_idx] if c_idx < len(r) else ''
                        if row_idx == 0:
                            row_cells.append(Paragraph(clean_text(val), table_header_style))
                        else:
                            row_cells.append(Paragraph(clean_text(val), table_cell_style))
                    formatted_data.append(row_cells)
                
                # Column widths roughly dividing page width 532
                col_width = 532.0 / num_cols
                t = Table(formatted_data, colWidths=[col_width]*num_cols)
                t.setStyle(TableStyle([
                    ('BACKGROUND', (0,0), (-1,0), primary_color),
                    ('ALIGN', (0,0), (-1,-1), 'LEFT'),
                    ('VALIGN', (0,0), (-1,-1), 'TOP'),
                    ('GRID', (0,0), (-1,-1), 0.5, table_border),
                    ('ROWBACKGROUNDS', (0,1), (-1,-1), [colors.white, table_alt_bg]),
                    ('TOPPADDING', (0,0), (-1,-1), 4),
                    ('BOTTOMPADDING', (0,0), (-1,-1), 4),
                    ('LEFTPADDING', (0,0), (-1,-1), 5),
                    ('RIGHTPADDING', (0,0), (-1,-1), 5),
                ]))
                story.append(Spacer(1, 4))
                story.append(t)
                story.append(Spacer(1, 6))
            table_rows = []
            in_table = False

        if not line:
            story.append(Spacer(1, 4))
            i += 1
            continue

        if line.startswith('# '):
            story.append(Paragraph(clean_text(line[2:]), title_style))
            story.append(HRFlowable(width="100%", thickness=1.5, color=primary_color, spaceAfter=8))
        elif line.startswith('## '):
            story.append(Paragraph(clean_text(line[3:]), h1_style))
        elif line.startswith('### '):
            story.append(Paragraph(clean_text(line[4:]), h2_style))
        elif line.startswith('- ') or line.startswith('* '):
            bullet_text = "&bull; " + clean_text(line[2:])
            story.append(Paragraph(bullet_text, bullet_style))
        elif re.match(r'^\d+\.\s', line):
            m = re.match(r'^(\d+\.)\s(.*)', line)
            num_text = f"<b>{m.group(1)}</b> " + clean_text(m.group(2))
            story.append(Paragraph(num_text, bullet_style))
        elif line.startswith('---'):
            story.append(HRFlowable(width="100%", thickness=0.5, color=table_border, spaceBefore=4, spaceAfter=6))
        elif line.startswith('+--') or line.startswith('|  '):
            # Preformatted ASCII diagram
            ascii_text = f"<font face='Courier' size='7'>{clean_text(line)}</font>"
            story.append(Paragraph(ascii_text, body_style))
        else:
            story.append(Paragraph(clean_text(line), body_style))

        i += 1

    # End of document table flush
    if in_table and table_rows:
        num_cols = max(len(r) for r in table_rows)
        formatted_data = []
        for row_idx, r in enumerate(table_rows):
            row_cells = []
            for c_idx in range(num_cols):
                val = r[c_idx] if c_idx < len(r) else ''
                if row_idx == 0:
                    row_cells.append(Paragraph(clean_text(val), table_header_style))
                else:
                    row_cells.append(Paragraph(clean_text(val), table_cell_style))
            formatted_data.append(row_cells)
        col_width = 532.0 / num_cols
        t = Table(formatted_data, colWidths=[col_width]*num_cols)
        t.setStyle(TableStyle([
            ('BACKGROUND', (0,0), (-1,0), primary_color),
            ('ALIGN', (0,0), (-1,-1), 'LEFT'),
            ('VALIGN', (0,0), (-1,-1), 'TOP'),
            ('GRID', (0,0), (-1,-1), 0.5, table_border),
            ('ROWBACKGROUNDS', (0,1), (-1,-1), [colors.white, table_alt_bg]),
            ('TOPPADDING', (0,0), (-1,-1), 4),
            ('BOTTOMPADDING', (0,0), (-1,-1), 4),
        ]))
        story.append(t)

    doc.build(story)
    print(f"Generated: {output_pdf_path}")

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    docs_dir = os.path.join(base_dir, "docs")
    
    tasks = [
        ("PROJECT_DOCUMENTATION.md", "PROJECT_DOCUMENTATION.pdf", "PayWise - Project Documentation"),
        ("CODE_EXPLAINED.md", "CODE_EXPLAINED.pdf", "PayWise - Codebase Explained"),
        ("MY_GUIDE.md", "MY_GUIDE.pdf", "PayWise - Owner's Guide & Viva Prep"),
    ]
    
    for md_file, pdf_file, title in tasks:
        in_path = os.path.join(docs_dir, md_file)
        out_path = os.path.join(docs_dir, pdf_file)
        if os.path.exists(in_path):
            markdown_to_pdf(in_path, out_path, title)
            # Also copy to root directory for easy grader access
            root_out = os.path.join(base_dir, pdf_file)
            import shutil
            shutil.copy2(out_path, root_out)
            print(f"Copied to root: {root_out}")
