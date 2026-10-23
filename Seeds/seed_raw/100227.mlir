module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %cst = arith.constant 4.035000e+01 : f64
    %0 = "tosa.const"() <{values = dense<7.11999988> : tensor<f32>}> : () -> tensor<f32>
    %1 = linalg.fill ins(%cst : f64) outs(%0 : tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %1 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

