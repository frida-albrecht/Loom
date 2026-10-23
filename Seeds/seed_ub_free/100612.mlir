#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.232000e+01> : tensor<45x80x16xf32>}> : () -> tensor<45x80x16xf32>
    %c9 = arith.constant 9 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %1 = "tosa.const"() <{values = dense<-5.645000e+01> : tensor<1x4xf32>}> : () -> tensor<1x4xf32>
    %c79 = arith.constant 79 : index
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel"]} outs(%1 : tensor<1x4xf32>) {
    ^bb0(%out: f32):
      %3 = linalg.index 0 : index
      %4 = arith.addi %c9, %3 : index
      %5 = arith.addi %4, %c4 : index
      %6 = linalg.index 1 : index
      %7 = arith.addi %c1, %6 : index
      %8 = arith.addi %7, %c2 : index
      %extracted = tensor.extract %0[%5, %c79, %8] : tensor<45x80x16xf32>
      linalg.yield %extracted : f32
    } -> tensor<1x4xf32>
    %cast = tensor.cast %2 : tensor<1x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

