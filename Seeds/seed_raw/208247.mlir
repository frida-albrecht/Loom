module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-75> : tensor<6xi16>}> : () -> tensor<6xi16>
    %1 = "tosa.const"() <{values = dense<96.959999> : tensor<7x8x6xf32>}> : () -> tensor<7x8x6xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<6xi16>) -> tensor<1xi16>
    %3 = tosa.bitwise_or %2, %2 : (tensor<1xi16>, tensor<1xi16>) -> tensor<1xi16>
    %4 = tosa.add %3, %3 : (tensor<1xi16>, tensor<1xi16>) -> tensor<1xi16>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<1xi16>) -> tensor<1xi16>
    %6 = tosa.tanh %1 : (tensor<7x8x6xf32>) -> tensor<7x8x6xf32>
    %7 = tosa.exp %6 : (tensor<7x8x6xf32>) -> tensor<7x8x6xf32>
    %8 = tosa.sub %7, %7 : (tensor<7x8x6xf32>, tensor<7x8x6xf32>) -> tensor<7x8x6xf32>
    %9 = tosa.log %6 : (tensor<7x8x6xf32>) -> tensor<7x8x6xf32>
    %10 = tosa.argmax %8 {axis = 2 : i32} : (tensor<7x8x6xf32>) -> tensor<7x8xi32>
    %11 = tosa.argmax %9 {axis = 1 : i32} : (tensor<7x8x6xf32>) -> tensor<7x6xi32>
    %cast = tensor.cast %5 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %10 : tensor<7x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %11 : tensor<7x6xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

