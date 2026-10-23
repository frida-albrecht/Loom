#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.523000e+01> : tensor<8x32x32x32xf32>}> : () -> tensor<8x32x32x32xf32>
    %1 = "tosa.const"() <{values = dense<-1.543400e+02> : tensor<32x32x32xf32>}> : () -> tensor<32x32x32xf32>
    %cst = arith.constant dense<3.000000e-02> : tensor<32x32x32xf32>
    %cst_0 = arith.constant dense<6.000000e-01> : tensor<32xf32>
    %cst_1 = arith.constant 0.000000e+00 : f32
    %2 = scf.forall (%arg0, %arg1) in (8, 32) shared_outs(%arg2 = %0) -> (tensor<8x32x32x32xf32>) {
      %extracted_slice = tensor.extract_slice %arg2[%arg0, %arg1, 0, 0] [1, 1, 32, 32] [1, 1, 1, 1] : tensor<8x32x32x32xf32> to tensor<32x32xf32>
      %3 = linalg.fill ins(%cst_1 : f32) outs(%extracted_slice : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = linalg.batch_reduce_matmul ins(%1, %cst : tensor<32x32x32xf32>, tensor<32x32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%4, %cst_0 : tensor<32x32xf32>, tensor<32xf32>) outs(%extracted_slice : tensor<32x32xf32>) {
      ^bb0(%in: f32, %in_2: f32, %out: f32):
        %7 = arith.addf %in, %in_2 : f32
        linalg.yield %7 : f32
      } -> tensor<32x32xf32>
      %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%5 : tensor<32x32xf32>) outs(%extracted_slice : tensor<32x32xf32>) {
      ^bb0(%in: f32, %out: f32):
        %7 = arith.maximumf %in, %cst_1 : f32
        linalg.yield %7 : f32
      } -> tensor<32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %6 into %arg2[%arg0, %arg1, 0, 0] [1, 1, 32, 32] [1, 1, 1, 1] : tensor<32x32xf32> into tensor<8x32x32x32xf32>
      }
    }
    %cast = tensor.cast %2 : tensor<8x32x32x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

