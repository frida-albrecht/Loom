module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.940000e+01> : tensor<2x10x7x4xf32>}> : () -> tensor<2x10x7x4xf32>
    %1 = "tosa.const"() <{values = dense<-43> : tensor<2x7xi16>}> : () -> tensor<2x7xi16>
    %2 = "tosa.const"() <{values = dense<164> : tensor<2x1xi16>}> : () -> tensor<2x1xi16>
    %3 = tosa.floor %0 : (tensor<2x10x7x4xf32>) -> tensor<2x10x7x4xf32>
    %4 = tosa.concat %3, %3 {axis = 3 : i32} : (tensor<2x10x7x4xf32>, tensor<2x10x7x4xf32>) -> tensor<2x10x7x8xf32>
    %5 = tosa.logical_right_shift %1, %2 : (tensor<2x7xi16>, tensor<2x1xi16>) -> tensor<2x7xi16>
    %6 = tosa.sub %4, %4 : (tensor<2x10x7x8xf32>, tensor<2x10x7x8xf32>) -> tensor<2x10x7x8xf32>
    %7 = tosa.logical_right_shift %5, %5 : (tensor<2x7xi16>, tensor<2x7xi16>) -> tensor<2x7xi16>
    %8 = tosa.reduce_sum %7 {axis = 1 : i32} : (tensor<2x7xi16>) -> tensor<2x1xi16>
    %9 = tosa.clz %5 : (tensor<2x7xi16>) -> tensor<2x7xi16>
    %10 = tosa.reverse %8 {axis = 1 : i32} : (tensor<2x1xi16>) -> tensor<2x1xi16>
    %11 = tosa.tanh %4 : (tensor<2x10x7x8xf32>) -> tensor<2x10x7x8xf32>
    %cast = tensor.cast %6 : tensor<2x10x7x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<2x7xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %10 : tensor<2x1xi16> to tensor<*xi16>
    %cast_2 = tensor.cast %11 : tensor<2x10x7x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefI16(%cast_1) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}

