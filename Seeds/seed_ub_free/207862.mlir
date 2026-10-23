module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-126> : tensor<7x1x10xi32>}> : () -> tensor<7x1x10xi32>
    %1 = "tosa.const"() <{values = dense<71> : tensor<7x64x10xi32>}> : () -> tensor<7x64x10xi32>
    %2 = "tosa.const"() <{values = dense<-7.276000e+01> : tensor<10x10x6x7xf32>}> : () -> tensor<10x10x6x7xf32>
    %3 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<7x1x10xi32>, tensor<7x64x10xi32>) -> tensor<7x65x10xi32>
    %4 = tosa.log %2 : (tensor<10x10x6x7xf32>) -> tensor<10x10x6x7xf32>
    %5 = tosa.log %4 : (tensor<10x10x6x7xf32>) -> tensor<10x10x6x7xf32>
    %cast = tensor.cast %3 : tensor<7x65x10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<10x10x6x7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

