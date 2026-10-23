module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6> : tensor<5x7xi8>}> : () -> tensor<5x7xi8>
    %1 = "tosa.const"() <{values = dense<-65> : tensor<2x1x6x5xi32>}> : () -> tensor<2x1x6x5xi32>
    %2 = "tosa.const"() <{values = dense<-20> : tensor<2x1x1x5xi32>}> : () -> tensor<2x1x1x5xi32>
    %3 = "tosa.const"() <{values = dense<1.454700e+02> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %4 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<5x7xi8>) -> tensor<1x7xi8>
    %5 = tosa.intdiv %1, %2 : (tensor<2x1x6x5xi32>, tensor<2x1x1x5xi32>) -> tensor<2x1x6x5xi32>
    %6 = tosa.log %3 : (tensor<1x7xf32>) -> tensor<1x7xf32>
    %7 = tosa.clz %5 : (tensor<2x1x6x5xi32>) -> tensor<2x1x6x5xi32>
    %8 = tosa.ceil %6 : (tensor<1x7xf32>) -> tensor<1x7xf32>
    %cast = tensor.cast %4 : tensor<1x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<2x1x6x5xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %8 : tensor<1x7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

