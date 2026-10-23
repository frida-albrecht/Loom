module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.825000e+01> : tensor<2x1x1xf32>}> : () -> tensor<2x1x1xf32>
    %1 = tosa.rsqrt %0 : (tensor<2x1x1xf32>) -> tensor<2x1x1xf32>
    %2 = tosa.sigmoid %1 : (tensor<2x1x1xf32>) -> tensor<2x1x1xf32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<2x1x1xf32>) -> tensor<2x1x1xf32>
    %cast = tensor.cast %3 : tensor<2x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

