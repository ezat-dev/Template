package com.tkheat.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tkheat.domain.Corp;
import com.tkheat.domain.Fac;
import com.tkheat.domain.Measure;
import com.tkheat.domain.Permission;
import com.tkheat.domain.Product;
import com.tkheat.domain.Standard;
import com.tkheat.domain.Users;
import com.tkheat.service.ManagementService;

@Controller
public class ManagementController {

	@Autowired
	private ManagementService managementService;
	
	//파일 업로드
	private String saveFiles(MultipartFile[] files, String uploadDir) throws IOException {
		if (files == null || files.length == 0) return null;

		File directory = new File(uploadDir);
		if (!directory.exists()) directory.mkdirs();

		for (MultipartFile file : files) {
			if (!file.isEmpty()) {
				String originalFilename = file.getOriginalFilename();
				String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());

				String ext = "";
				int dotIndex = originalFilename.lastIndexOf('.');
				if (dotIndex > 0) {
					ext = originalFilename.substring(dotIndex);
					originalFilename = originalFilename.substring(0, dotIndex);
				}

				String savedFilename = originalFilename + "_" + timestamp + ext;
				File destination = new File(uploadDir + "/" + savedFilename);
				file.transferTo(destination);

				return savedFilename; //
			}
		}
		return null;
	}


	@RequestMapping(value = "/management/login", method = RequestMethod.GET)
	public String login(Users users) {
		return "/management/login.jsp";

	}

	@RequestMapping(value = "/management/sideBar", method = RequestMethod.GET)
	public String sideBar(Users users) {
		return "/include/sideBar.jsp";

	}

	//제품등록 - 화면로드
	@RequestMapping(value = "/management/productInsert", method = RequestMethod.GET)
	public String productInsert(Users users) {

		return "/management/productInsert.jsp";
	}	 
	
	//푸시알림 관리 페이지
	@RequestMapping(value = "/management/pushAlarm", method = RequestMethod.GET)
	public String pushAlarm(Users users) {

		return "/management/pushAlarm.jsp";
	}	


	//제품등록, 수정 - insert,update
	@RequestMapping(value = "/management/productInsert/productInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> productInsertSave(
			@ModelAttribute Product product,
			@RequestParam("mode") String mode,
			@RequestParam(value = "product_file_url", required = false) MultipartFile[] files1,
			@RequestParam(value = "apperance_file_url", required = false) MultipartFile[] files2,
			@RequestParam(value = "heat_file_url", required = false) MultipartFile[] files3) { 
		
		System.out.println("저장 컨트롤러 도착");

		Map<String, Object> result = new HashMap<>();

		System.out.println(product.getProd_code());
		System.out.println(product.getProd_date());

		try {

			String path = "D:/엑셀테스트/태경출력파일/사진/제품등록";

			String productFileName = saveFiles(files1, path);
			if (productFileName != null) product.setProduct_file_name(productFileName);

			String appearanceFileName = saveFiles(files2, path);
			if (appearanceFileName != null) product.setApperance_file_name(appearanceFileName);

			String heatFileName = saveFiles(files3, path);
			if (heatFileName != null) product.setHeat_file_name(heatFileName);

			if ("insert".equalsIgnoreCase(mode)) {
				managementService.productInsertSave(product);
			} else if ("update".equalsIgnoreCase(mode)) {
				managementService.productUpdateSave(product);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
			e.printStackTrace();
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//제품 삭제 - delete
	@RequestMapping(value = "/management/productInsert/productDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> productDelete(@RequestParam("prod_code") int prod_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			managementService.productDelete(prod_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//전체 제품 목록 조회
	@RequestMapping(value = "/management/productInsert/productList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getProductList(
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Product product = new Product();



		List<Product> productList = managementService.getProductList(product);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<productList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("prod_code", productList.get(i).getProd_code());
			rowMap.put("prod_date", productList.get(i).getProd_date());
			rowMap.put("corp_name", productList.get(i).getCorp_name());
			rowMap.put("corp_code", productList.get(i).getCorp_code());
			rowMap.put("prod_name", productList.get(i).getProd_name());
			rowMap.put("prod_no", productList.get(i).getProd_no());
			rowMap.put("prod_gyu", productList.get(i).getProd_gyu());
			rowMap.put("prod_jai", productList.get(i).getProd_jai());
			rowMap.put("tech_te", productList.get(i).getTech_te());
			rowMap.put("prod_danj", productList.get(i).getProd_danj());
			rowMap.put("prod_danw", productList.get(i).getProd_danw());
			rowMap.put("prod_dang", productList.get(i).getProd_dang());
			rowMap.put("prod_pg", productList.get(i).getProd_pg());
			rowMap.put("prod_gd1", productList.get(i).getProd_gd1());
			rowMap.put("prod_gd2", productList.get(i).getProd_gd2());
			rowMap.put("prod_gd3", productList.get(i).getProd_gd3());
			rowMap.put("prod_sg", productList.get(i).getProd_sg());
			rowMap.put("prod_no", productList.get(i).getProd_no());
			rowMap.put("prod_cno", productList.get(i).getProd_cno());
			rowMap.put("prod_pwsno", productList.get(i).getProd_pwsno());
			rowMap.put("prod_do", productList.get(i).getProd_do());
			rowMap.put("prod_refno", productList.get(i).getProd_refno());
			rowMap.put("prod_kijong", productList.get(i).getProd_kijong());
			rowMap.put("prod_e1", productList.get(i).getProd_e1());
			rowMap.put("prod_e3", productList.get(i).getProd_e3());
			rowMap.put("prod_khecd", productList.get(i).getProd_khecd());
			rowMap.put("prod_khtcd", productList.get(i).getProd_khtcd());
			rowMap.put("prod_gd5", productList.get(i).getProd_gd5());
			rowMap.put("product_file_name", productList.get(i).getProduct_file_name());
			rowMap.put("apperance_file_name", productList.get(i).getApperance_file_name());
			rowMap.put("heat_file_name", productList.get(i).getHeat_file_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	 


	//제품 더블클릭조회
	@RequestMapping(value = "/management/productInsert/productInsertDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> productInsertDetail(
			@RequestParam int prod_code) {
		System.out.println("더블클릭 로그");
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Product product = new Product();
		product.setProd_code(prod_code);

		Product prodList = managementService.productInsertDetail(product);

		rtnMap.put("data",prodList);

		return rtnMap; 
	}
	
	//모달창에 사진 출력
	@RequestMapping(value = "/management/image/product/{filename:.+}", method = RequestMethod.GET)
    public void serveProductImage(@PathVariable String filename, HttpServletResponse response) throws IOException {
		System.out.println("사진 출력 컨트롤러 도착");
        String baseDir = "D:/엑셀테스트/태경출력파일/사진/제품등록/";
        File file = new File(baseDir + filename);

        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = Files.probeContentType(file.toPath());
        if (mimeType == null) mimeType = "application/octet-stream";

        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

        Files.copy(file.toPath(), response.getOutputStream());
    }

	//거래처등록 - 화면로드
	@RequestMapping(value = "/management/cutumInsert", method = RequestMethod.GET)
	public String custumInsert(Users users) {

		return "/management/cutumInsert.jsp";
	}

	//전체 거래처목록 조회
	@RequestMapping(value = "/management/cutumInsert/cutumInsertList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCorpList(
			@RequestParam String corp_name,
			@RequestParam String corp_plc,
			@RequestParam String corp_gubn,
			@RequestParam String corp_mast
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Corp corp = new Corp();
		corp.setCorp_name(corp_name);
		corp.setCorp_plc(corp_plc);
		corp.setCorp_gubn(corp_gubn);
		corp.setCorp_mast(corp_mast);


		List<Corp> corpList = managementService.getCorpList(corp);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<corpList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("corp_code", corpList.get(i).getCorp_code());
			rowMap.put("corp_gubn", corpList.get(i).getCorp_gubn());
			rowMap.put("corp_name", corpList.get(i).getCorp_name());
			rowMap.put("corp_name2", corpList.get(i).getCorp_name2());
			rowMap.put("corp_no", corpList.get(i).getCorp_no());
			rowMap.put("corp_tel", corpList.get(i).getCorp_tel());
			rowMap.put("corp_fax", corpList.get(i).getCorp_fax());
			rowMap.put("corp_boss", corpList.get(i).getCorp_boss());
			rowMap.put("corp_mast", corpList.get(i).getCorp_mast());
			rowMap.put("corp_plc", corpList.get(i).getCorp_plc());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//거래처등록 더블클릭조회
	@RequestMapping(value = "/management/cutumInsert/cutumInsertDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> cutumInsertDetail(
			@RequestParam int corp_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Corp corp = new Corp();
		corp.setCorp_code(corp_code);

		/*
		 * standard.setCorp_name(corp_name); standard.setProd_name(prod_name);
		 * standard.setProd_no(prod_no); standard.setFac_name(fac_name);
		 */


		Corp corpList = managementService.cutumInsertDetail(corp);

		rtnMap.put("data",corpList);

		return rtnMap; 
	}

	//거래처 등록 and 수정
	@RequestMapping(value = "/management/cutumInsert/cutumInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cutumInsertSave(
			@ModelAttribute Corp corp,
			@RequestParam("mode") String mode) { 
		Map<String, Object> result = new HashMap<>();

		System.out.println("1");
		System.out.println(corp.getCorp_gyul1());
		System.out.println("2");


		if(corp.getCorp_gyul1() == null) {
			corp.setCorp_gyul1("0");
		}else if("on".equals(corp.getCorp_gyul1())) {
			corp.setCorp_gyul1("1");
		}

		try {
			if ("insert".equalsIgnoreCase(mode)) {
				managementService.cutumInsertSave(corp);
			} else if ("update".equalsIgnoreCase(mode)) {
				managementService.cutumUpdateSave(corp);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}

	//거래처 삭제 - delete
	@RequestMapping(value = "/management/cutumInsert/cutumDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cutumDelete(@RequestParam("corp_code") int corp_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			managementService.cutumDelete(corp_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}





	//설비등록 - 화면로드
	@RequestMapping(value = "/management/facInsert", method = RequestMethod.GET)
	public String facInsert(Users users) {

		return "/management/facInsert.jsp";
	}	

	//전체 설비목록 조회
	@RequestMapping(value = "/management/facInsert/getFacList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getFacList(
			@RequestParam String fac_no,
			@RequestParam String fac_name
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Fac fac = new Fac();
		fac.setFac_no(fac_no);
		fac.setFac_name(fac_name);

		List<Fac> facList = managementService.getFacList(fac);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<facList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("fac_no", facList.get(i).getFac_no());
			rowMap.put("fac_name", facList.get(i).getFac_name());
			rowMap.put("fac_gyu", facList.get(i).getFac_gyu());
			rowMap.put("fac_hyun", facList.get(i).getFac_hyun());
			rowMap.put("fac_yong", facList.get(i).getFac_yong());
			rowMap.put("fac_plc", facList.get(i).getFac_plc());
			rowMap.put("fac_able", facList.get(i).getFac_able());
			rowMap.put("fac_make", facList.get(i).getFac_make());
			rowMap.put("fac_cbuy", facList.get(i).getFac_cbuy());
			rowMap.put("fac_code", facList.get(i).getFac_code());
			rowMap.put("fac_file_name", facList.get(i).getFac_file_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//설비 더블클릭조회
	@RequestMapping(value = "/management/facInsert/facInsertDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> facInsertDetail(
			@RequestParam int fac_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Fac fac = new Fac();
		fac.setFac_code(fac_code);

		Fac facList = managementService.facInsertDetail(fac);

		rtnMap.put("data",facList);

		return rtnMap; 
	}
	
	//모달창에 이미지 출력
	@RequestMapping(value = "/management/image/fac/{filename:.+}", method = RequestMethod.GET)
    public void serveeProductImage(@PathVariable String filename, HttpServletResponse response) throws IOException {
		System.out.println("사진 출력 컨트롤러 도착");
        String baseDir = "D:/엑셀테스트/설비등록/";
        File file = new File(baseDir + filename);

        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = Files.probeContentType(file.toPath());
        if (mimeType == null) mimeType = "application/octet-stream";

        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

        Files.copy(file.toPath(), response.getOutputStream());
    }




	//설비 등록 and 수정
	@RequestMapping(value = "/management/facInsert/facInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> facInsertSave(
			@ModelAttribute Fac fac,
			@RequestParam("mode") String mode,
			@RequestParam(value = "fac_file_url", required = false) MultipartFile[] files1) { 
		Map<String, Object> result = new HashMap<>();

		try {
			
			String path = "D:/엑셀테스트/태경출력파일/사진/설비등록";

			String productFileName = saveFiles(files1, path);
			if (productFileName != null) fac.setFac_file_name(productFileName);
			
			if ("insert".equalsIgnoreCase(mode)) {
				managementService.facInsertSave(fac);
			} else if ("update".equalsIgnoreCase(mode)) {
				managementService.facUpdateSave(fac);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//설비 삭제 - delete
	@RequestMapping(value = "/management/facInsert/facDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> facDelete(@RequestParam("fac_code") int fac_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			managementService.facDelete(fac_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//침탄로기준등록 - 화면로드
	@RequestMapping(value = "/management/chimStandard", method = RequestMethod.GET)
	public String chimStandard(Users users) {

		return "/management/chimStandard.jsp";
	}		 

	//침탄로 작업표준 조회
	@RequestMapping(value = "/management/chimStandardInsert/getChimStandardList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChimStandardList(
			/*
			 * @RequestParam String corp_name,
			 * 
			 * @RequestParam String prod_name,
			 * 
			 * @RequestParam String prod_no,
			 * 
			 * @RequestParam String fac_name
			 */
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Standard standard = new Standard();

		/*
		 * standard.setCorp_name(corp_name); standard.setProd_name(prod_name);
		 * standard.setProd_no(prod_no); standard.setFac_name(fac_name);
		 */


		List<Standard> chimStandardList = managementService.getChimStandardList(standard);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<chimStandardList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("wstd_code", chimStandardList.get(i).getWstd_code());
			rowMap.put("corp_name", chimStandardList.get(i).getCorp_name());
			rowMap.put("prod_name", chimStandardList.get(i).getProd_name());
			rowMap.put("prod_no", chimStandardList.get(i).getProd_no());
			rowMap.put("prod_kijong", chimStandardList.get(i).getProd_kijong());
			rowMap.put("prod_jai", chimStandardList.get(i).getProd_jai());
			rowMap.put("prod_dang", chimStandardList.get(i).getProd_dang());
			rowMap.put("fac_code", chimStandardList.get(i).getFac_code());
			rowMap.put("tech_te", chimStandardList.get(i).getTech_te());
			rowMap.put("prod_code", chimStandardList.get(i).getProd_code());
			rowMap.put("fac_name", chimStandardList.get(i).getFac_name());
			rowMap.put("wstd_code", chimStandardList.get(i).getWstd_code());
			rowMap.put("wstd_chim_file_name1", chimStandardList.get(i).getWstd_chim_file_name1());
			rowMap.put("wstd_chim_file_name2", chimStandardList.get(i).getWstd_chim_file_name2());


			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	//침탄로 작업표준 더블클릭조회
	@RequestMapping(value = "/management/chimStandardInsert/getChimStandardDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChimStandardDetail(
			@RequestParam int wstd_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Standard standard = new Standard();
		standard.setWstd_code(wstd_code);

		/*
		 * standard.setCorp_name(corp_name); standard.setProd_name(prod_name);
		 * standard.setProd_no(prod_no); standard.setFac_name(fac_name);
		 */


		Standard chimStandardList = managementService.getChimStandardDetail(standard);

		rtnMap.put("data",chimStandardList);

		return rtnMap; 
	}
	
	//모달창에 침탄로 이미지 출력
	@RequestMapping(value = "/management/image/chim/{filename:.+}", method = RequestMethod.GET)
    public void serveeeProductImage(@PathVariable String filename, HttpServletResponse response) throws IOException {
		System.out.println("사진 출력 컨트롤러 도착");
        String baseDir = "D:/엑셀테스트/태경출력파일/사진/침탄로작업표준/";
        File file = new File(baseDir + filename);

        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = Files.probeContentType(file.toPath());
        if (mimeType == null) mimeType = "application/octet-stream";

        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

        Files.copy(file.toPath(), response.getOutputStream());
    }



	//침탄표준 등록 and 수정
	@RequestMapping(value = "/management/chimStandardInsert/chimStandardInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> chimStandardSave(
			@ModelAttribute Standard standard,
			@RequestParam("mode") String mode,
			@RequestParam(value = "wstd_chim_file_url1", required = false) MultipartFile[] files1,
			@RequestParam(value = "wstd_chim_file_url2", required = false) MultipartFile[] files2) { 
		Map<String, Object> result = new HashMap<>();

		try {
			
			String path = "D:/엑셀테스트/태경출력파일/사진/침탄로작업표준";

			String productFileName1 = saveFiles(files1, path);
			System.out.println("productFileName1"+productFileName1);
			if (productFileName1 != null) standard.setWstd_chim_file_name1(productFileName1);
			
			String productFileName2 = saveFiles(files2, path);
			System.out.println("productFileName2"+productFileName2);
			if (productFileName2 != null) standard.setWstd_chim_file_name2(productFileName2);
			
			if ("insert".equalsIgnoreCase(mode)) {
				managementService.chimStandardInsertSave(standard);
			} else if ("update".equalsIgnoreCase(mode)) {
				managementService.chimStandardUpdateSave(standard);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//침탄표준 삭제 - delete
	@RequestMapping(value = "/management/chimStandardInsert/chimStandardDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> chimStandardDelete(@RequestParam("wstd_code") int wstd_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			managementService.chimStandardDelete(wstd_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}




	//작업자등록 - 화면로드
	@RequestMapping(value = "/management/userinsert", method = RequestMethod.GET)
	public String userinsert(Users users) {
		return "/management/userinsert.jsp";	       
	}

	//작업자등록 - 저장
	@RequestMapping(value = "/management/userinsert/save", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertUser(@RequestBody Users users) {
		Map<String, Object> rtnMap = new HashMap<>();
		try {
			managementService.insertUser(users); 
			rtnMap.put("status", "success");
			rtnMap.put("message", "사용자 등록 성공");
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("status", "error");
			rtnMap.put("message", "사용자 등록 실패: " + e.getMessage());
		}
		return rtnMap; 
	}

	//고주파로작업표준 - 화면로드
	@RequestMapping(value = "/management/goStandard", method = RequestMethod.GET)
	public String goStandard(Users users) {

		return "/management/goStandard.jsp";
	}	

	//고주파로 작업표준 조회
	@RequestMapping(value = "/management/goStandardInsert/getGoStandardList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getGoStandardList(
			@RequestParam String corp_name,
			@RequestParam String prod_name,
			@RequestParam String prod_no
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Standard standard = new Standard();

		standard.setCorp_name(corp_name);
		standard.setProd_name(prod_name);
		standard.setProd_no(prod_no);

		List<Standard> goStandardList = managementService.getGoStandardList(standard);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<goStandardList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_name", goStandardList.get(i).getCorp_name());
			rowMap.put("prod_name", goStandardList.get(i).getProd_name());
			rowMap.put("prod_no", goStandardList.get(i).getProd_no());
			rowMap.put("prod_kijong", goStandardList.get(i).getProd_kijong());
			rowMap.put("prod_jai", goStandardList.get(i).getProd_jai());
			rowMap.put("prod_dang", goStandardList.get(i).getProd_dang());
			rowMap.put("fac_code", goStandardList.get(i).getFac_code());
			rowMap.put("tech_te", goStandardList.get(i).getTech_te());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}




	//PLUG점검기준등록 - 화면로드
	@RequestMapping(value = "/management/plugInspection", method = RequestMethod.GET)
	public String plugInspection(Users users) {

		return "/management/plugInspection.jsp";
	}	







	/*
	 * //전체 제품목록 조회
	 * 
	 * @RequestMapping(value = "/management/authority/productList", method =
	 * RequestMethod.POST)
	 * 
	 * @ResponseBody public Map<String, Object> getproductList() { Map<String,
	 * Object> rtnMap = new HashMap<String, Object>();
	 * 
	 * List<Product> prodList = managementService.getProductList();
	 * 
	 * List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String,
	 * Object>>(); for(int i=0; i<prodList.size(); i++) { HashMap<String, Object>
	 * rowMap = new HashMap<String, Object>(); rowMap.put("idx", (i+1));
	 * rowMap.put("prod_no", prodList.get(i).getProd_no()); rowMap.put("prod_name",
	 * prodList.get(i).getProd_name()); rowMap.put("prod_gyu",
	 * prodList.get(i).getProd_gyu()); rowMap.put("prod_jai",
	 * prodList.get(i).getProd_jai()); rowMap.put("prod_model",
	 * prodList.get(i).getProd_model());
	 * 
	 * rtnList.add(rowMap); }
	 * 
	 * rtnMap.put("last_page",1); rtnMap.put("data",rtnList);
	 * 
	 * return rtnMap; }
	 */ 

	//사원별 권한등록 화면 로드
	@RequestMapping(value = "/management/authority", method = RequestMethod.GET)
	public String authority(Users users) {

		return "/management/authority.jsp";	       
	}

	//전체 사용자목록 조회
	@RequestMapping(value = "/management/authority/userList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getUserList(
			@RequestParam String user_buso,
			@RequestParam String user_jick,
			@RequestParam String user_name,
			@RequestParam String user_ret) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Users user = new Users();
		user.setUser_buso(user_buso);
		user.setUser_jick(user_jick);
		user.setUser_name(user_name);
		user.setUser_ret(user_ret);

		List<Users> userList = managementService.getUserList(user);


		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<userList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("user_no", userList.get(i).getUser_no());
			rowMap.put("user_buso", userList.get(i).getUser_buso());
			rowMap.put("user_code", userList.get(i).getUser_code());
			rowMap.put("user_jick", userList.get(i).getUser_jick());
			rowMap.put("user_name", userList.get(i).getUser_name());
			rowMap.put("user_jdate", userList.get(i).getUser_jdate());
			rowMap.put("user_ret", userList.get(i).getUser_ret());
			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//사원별 권한등록 사용자 선택
	@RequestMapping(value = "/management/authority/userSelect", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> authorityUserSelect(
			@RequestParam(required = false) int user_code){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Permission permission = new Permission();
		permission.setUser_code(user_code);

		Permission selectPermission = managementService.authorityUserSelect(permission);

		rtnMap.put("data", selectPermission);

		return rtnMap;
	}


	//사원별 권한등록 사용자 선택 후 수정
	@RequestMapping(value = "/management/authority/userSelectSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> authorityUserSelectSave(@ModelAttribute Permission permission){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		managementService.authorityUserSelectSave(permission);

		return rtnMap;
	}	 


	//측정기기관리 - 화면로드
	@RequestMapping(value = "/management/measurement", method = RequestMethod.GET)
	public String measurement(Users users) {

		return "/management/measurement.jsp";
	}	



	//측정기기 목록 조회
	@RequestMapping(value = "/management/measurement/measureList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMeasureList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Measure> measureList = managementService.getMeasureList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<measureList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ter_use", measureList.get(i).getTer_use());
			rowMap.put("ter_name", measureList.get(i).getTer_name());
			rowMap.put("ter_code", measureList.get(i).getTer_code());
			rowMap.put("ter_end_gum", measureList.get(i).getTer_end_gum());
			rowMap.put("ter_next_gum", measureList.get(i).getTer_next_gum());
			rowMap.put("ter_gum", measureList.get(i).getTer_gum());
			rowMap.put("ter_model", measureList.get(i).getTer_model());
			rowMap.put("ter_buy", measureList.get(i).getTer_buy());
			rowMap.put("ter_bdate", measureList.get(i).getTer_bdate());
			rowMap.put("ter_bmon", measureList.get(i).getTer_bmon());
			rowMap.put("file_name", measureList.get(i).getFile_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	


	//측정기기 등록 and 수정
	@RequestMapping(value = "/management/measurement/measureInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> measureInsertSave(
			@ModelAttribute Measure measure,
			@RequestParam("mode") String mode,
			@RequestParam(value = "file_url", required = false) MultipartFile[] files1) { 
		Map<String, Object> result = new HashMap<>();

		try {
			
			String path = "D:/엑셀테스트/태경출력파일/사진/측정기기관리";

			String productFileName = saveFiles(files1, path);
			if (productFileName != null) measure.setFile_name(productFileName);
			
			if ("insert".equalsIgnoreCase(mode)) {
				managementService.measureInsertSave(measure);
			} else if ("update".equalsIgnoreCase(mode)) {
				managementService.measureUpdateSave(measure);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}
	
	//모달창에 측정기기 이미지 출력
	@RequestMapping(value = "/management/measure/image/{filename:.+}", method = RequestMethod.GET)
    public void measureImage(@PathVariable String filename, HttpServletResponse response) throws IOException {
		System.out.println("사진 출력 컨트롤러 도착");
        String baseDir = "D:/엑셀테스트/태경출력파일/사진/측정기기관리/";
        File file = new File(baseDir + filename);

        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = Files.probeContentType(file.toPath());
        if (mimeType == null) mimeType = "application/octet-stream";

        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

        Files.copy(file.toPath(), response.getOutputStream());
    }


	//측정기기 삭제 - delete
	@RequestMapping(value = "/management/measurement/measureDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> measureDelete(@RequestParam("ter_code") int ter_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			managementService.measureDelete(ter_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}
	
	//측정기기관리 더블클릭조회
	@RequestMapping(value = "/management/getMeasurmentDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMeasureDetail(
			@RequestParam int ter_code) {
		System.out.println("측정기기관리 더블클릭조회");
		System.out.println("ter_code: "+ter_code);
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Measure measure = new Measure();
		measure.setTer_code(ter_code);
		System.out.println("measure.getTer_code(): "+measure.getTer_code());

		/*
		 * standard.setCorp_name(corp_name); standard.setProd_name(prod_name);
		 * standard.setProd_no(prod_no); standard.setFac_name(fac_name);
		 */


		measure = managementService.getMeasurmentDetail(measure);
		System.out.println(measure);

		rtnMap.put("data",measure);

		return rtnMap; 
	}




	//코일등록 - 화면로드
	@RequestMapping(value = "/management/coilInsert", method = RequestMethod.GET)
	public String coilInsert(Users users) {

		return "/management/coilInsert.jsp";
	}	

	//PLUG등록 화면 로드
	@RequestMapping(value = "/management/plugInsert", method = RequestMethod.GET)
	public String plugInsert(Users users) {

		return "/management/plugInsert.jsp";
	}		 

	@RequestMapping(value = "/management/authority/big_Page", method = RequestMethod.POST)
	@ResponseBody
	public List<Users> getBigPageList() {

		return managementService.getBigPageList(); 
	}

	@RequestMapping(value = "/management/authority/small_page", method = RequestMethod.POST)
	@ResponseBody
	public List<Users> getSmallPage(@RequestBody Map<String, String> requestData) {
		String pageBig = requestData.get("page_big"); 
		System.out.println("받은 page_big: " + pageBig);  


		return managementService.getSmallPageList(pageBig); 
	}
    @RequestMapping(value= "/management/adminPage", method = RequestMethod.GET)
    public String adminPage(Model model) {
        return "/management/adminPage.jsp"; 
    }


}

