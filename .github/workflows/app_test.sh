test-v9:
    needs: build
    runs-on: ubuntu-latest
    env:
      SPLUNK_VERSION: "9.0"
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2

      - name: Download package
        uses: actions/download-artifact@v4
        with:
          name: my-package
          path: app-dir/

      - name: Instal packages
        run: |
          sudo apt update -qq
          sudo apt-get install -y jq
     - name: Test On Splunk 9.0
        run: |
          chmod +x .github/workflows/app_test.sh
          .github/workflows/app_test.sh $SPLUNK_VERSION

  test-v9-2-1:
    needs: build
    runs-on: ubuntu-latest
    env:
      SPLUNK_VERSION: "9.2.1"
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2

      - name: Download package
        uses: actions/download-artifact@v4
        with:
          name: my-package
          path: app-dir/

      - name: Instal packages
        run: |
          sudo apt update -qq
          sudo apt-get install -y jq

      - name: Test On Splunk 9.2.1
        run: |
          chmod +x .github/workflows/app_test.sh
          .github/workflows/app_test.sh $SPLUNK_VERSION

      - name: Upload pytest report
        uses: actions/upload-artifact@v4
        with:
          name: pytest-report
          path: ${{ github.workspace }}/pytest-report.html
