module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-135> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<-7.431000e+01> : tensor<1x6x8x9xf32>}> : () -> tensor<1x6x8x9xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %3 = tosa.log %1 : (tensor<1x6x8x9xf32>) -> tensor<1x6x8x9xf32>
    %4 = tosa.exp %3 : (tensor<1x6x8x9xf32>) -> tensor<1x6x8x9xf32>
    %cast = tensor.cast %2 : tensor<1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<1x6x8x9xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

