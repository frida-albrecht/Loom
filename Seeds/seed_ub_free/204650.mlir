module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-98> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<-1.972000e+01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %2 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<1xi32>
    %3 = tosa.sigmoid %1 : (tensor<7xf32>) -> tensor<7xf32>
    %4 = tosa.bitwise_xor %2, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.abs %4 : (tensor<1xi32>) -> tensor<1xi32>
    %6 = tosa.reverse %3 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %5 : tensor<1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

