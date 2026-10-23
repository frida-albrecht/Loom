module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-82> : tensor<2x8x5xi64>}> : () -> tensor<2x8x5xi64>
    %1 = "tosa.const"() <{values = dense<60.6399993> : tensor<8xf32>}> : () -> tensor<8xf32>
    %2 = tosa.reverse %0 {axis = 1 : i32} : (tensor<2x8x5xi64>) -> tensor<2x8x5xi64>
    %3 = tosa.log %1 : (tensor<8xf32>) -> tensor<8xf32>
    %cast = tensor.cast %2 : tensor<2x8x5xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %3 : tensor<8xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

