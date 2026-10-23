module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.387000e+01> : tensor<64xf32>}> : () -> tensor<64xf32>
    %mapped = linalg.map outs(%0 : tensor<64xf32>)
      () {
        %cst = arith.constant 0.000000e+00 : f32
        linalg.yield %cst : f32
      }
    %cast = tensor.cast %mapped : tensor<64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

